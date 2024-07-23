--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3 (Debian 15.3-1.pgdg120+1)
-- Dumped by pg_dump version 15.4 (Ubuntu 15.4-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_superior_cpf_fkey;
ALTER TABLE ONLY public.tarefas DROP CONSTRAINT fk_funcionario;
ALTER TABLE ONLY public.tarefas DROP CONSTRAINT tarefas_pkey;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_pkey;
DROP TABLE public.tarefas;
DROP TABLE public.funcionario;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: funcionario; Type: TABLE; Schema: public; Owner: victorrm
--

CREATE TABLE public.funcionario (
    cpf character(11) NOT NULL,
    data_nasc date NOT NULL,
    nome character varying(100) NOT NULL,
    funcao character varying(15) NOT NULL,
    nivel character(1) NOT NULL,
    superior_cpf character varying(11),
    CONSTRAINT check_funcao_superior_cpf CHECK (((((funcao)::text = 'SUP_LIMPEZA'::text) AND (superior_cpf IS NULL)) OR ((funcao)::text <> 'SUP_LIMPEZA'::text))),
    CONSTRAINT check_superior_diferente CHECK ((cpf <> (superior_cpf)::bpchar)),
    CONSTRAINT funcionario_check CHECK (((((funcao)::text = 'LIMPEZA'::text) AND (superior_cpf IS NOT NULL)) OR ((funcao)::text = 'SUP_LIMPEZA'::text))),
    CONSTRAINT funcionario_funcao_check CHECK (((funcao)::text = ANY ((ARRAY['LIMPEZA'::character varying, 'SUP_LIMPEZA'::character varying])::text[]))),
    CONSTRAINT funcionario_nivel_check CHECK ((nivel = ANY (ARRAY['J'::bpchar, 'P'::bpchar, 'S'::bpchar])))
);


ALTER TABLE public.funcionario OWNER TO victorrm;

--
-- Name: tarefas; Type: TABLE; Schema: public; Owner: victorrm
--

CREATE TABLE public.tarefas (
    id bigint NOT NULL,
    descricao text NOT NULL,
    func_resp_cpf character(11),
    prioridade smallint NOT NULL,
    status character(1) NOT NULL,
    CONSTRAINT checa_prioridade CHECK (((prioridade >= 0) AND (prioridade <= 5))),
    CONSTRAINT checa_status CHECK ((status = ANY (ARRAY['P'::bpchar, 'E'::bpchar, 'C'::bpchar]))),
    CONSTRAINT check_func_resp_cpf_status CHECK (((status = 'P'::bpchar) OR ((status = ANY (ARRAY['E'::bpchar, 'C'::bpchar])) AND (func_resp_cpf IS NOT NULL))))
);


ALTER TABLE public.tarefas OWNER TO victorrm;

--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: victorrm
--

INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678911', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678912', '1980-03-08', 'Jose da Silva', 'LIMPEZA', 'J', '12345678911');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('99956412381', '1999-12-30', 'João Nascimento', 'LIMPEZA', 'J', '12345678911');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('99521568745', '1972-01-12', 'Alexander Almeida', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('99521687417', '1977-05-01', 'Emet Selch', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('99785496314', '1979-05-01', 'Hythlodaeus Ascian', 'LIMPEZA', 'P', '99521687417');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('87654321012', '1982-09-12', 'Ana Pereira', 'SUP_LIMPEZA', 'P', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('76543210923', '1990-07-25', 'Roberto Lima', 'SUP_LIMPEZA', 'J', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('32109876567', '2000-06-18', 'Fernando Oliveira', 'LIMPEZA', 'J', '76543210923');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('10987654389', '1993-04-22', 'Marcos Almeida', 'LIMPEZA', 'S', '76543210923');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('09876543290', '1985-08-14', 'Renata Ferreira', 'LIMPEZA', 'J', '99521687417');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('43210987656', '1998-11-20', 'Juliana Souza', 'LIMPEZA', 'S', '87654321012');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('21098765478', '1988-01-30', 'Luciana Barbosa', 'LIMPEZA', 'P', '87654321012');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432101', '1995-04-22', 'Alice Gomes', 'SUP_LIMPEZA', 'J', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432111', '1985-08-14', 'Ronaldo Fenomeno', 'LIMPEZA', 'J', '76543210923');


--
-- Data for Name: tarefas; Type: TABLE DATA; Schema: public; Owner: victorrm
--

INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483648, 'limpar portas do térreo', '12345678911', 4, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483647, 'limpar janelas da sala 203', '87654321012', 1, 'C');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483646, 'limpar chão do corredor central', '76543210923', 0, 'C');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483653, 'limpar portas do 1o andar', '76543210923', 2, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483651, 'limpar portas do 1o andar', '76543210923', 5, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483652, 'limpar portas do 2o andar', '76543210923', 5, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483659, 'Tarefa com func_resp_cpf NULL', NULL, 1, 'P');


--
-- Name: funcionario funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: victorrm
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (cpf);


--
-- Name: tarefas tarefas_pkey; Type: CONSTRAINT; Schema: public; Owner: victorrm
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT tarefas_pkey PRIMARY KEY (id);


--
-- Name: tarefas fk_funcionario; Type: FK CONSTRAINT; Schema: public; Owner: victorrm
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT fk_funcionario FOREIGN KEY (func_resp_cpf) REFERENCES public.funcionario(cpf) ON DELETE SET NULL;


--
-- Name: funcionario funcionario_superior_cpf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: victorrm
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_superior_cpf_fkey FOREIGN KEY (superior_cpf) REFERENCES public.funcionario(cpf);


--
-- PostgreSQL database dump complete
--

