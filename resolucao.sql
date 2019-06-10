--Q1

select c.id, c.nome
from candidato c
  join autarquia a using(cod)
where a.designacao = 'Lisboa';

--Q2

select count(*)
from candidato c
  join partido p using(sigla)
where p.nome = 'Partido da Direita'
  and c.votos > 1;
  
--Q3

select p.nome, avg(c.idade)
from candidato c
  join partido p using(sigla)
group by p.nome;

--Q4

select p.nome
from candidato c
  join partido p using(sigla)
group by p.nome
having avg(c.idade) > 45;

--Q5

with res as (
  select a.cod, a.designacao,
    sum(
      case p.nome
      when 'Partido do Meio' then 1 else 0
      end
    ) as s
  from autarquia a
  left join candidato using(cod)
  left join partido p using(sigla)
)

select res.cod, res.designacao
from res
where res.s = 0
order by 1;

--Q6

select a.designacao
  sum(
    case e.votou
    when 'F' then 1 else 0
    end
  )
from autarquia a
left join eleitor e using(cod)
group by 1
order by 2 desc;

--Q7

with t as (
  select a.designacao, count(*) as c
  from autarquia a
  join eleitor e using(cod)
  group by 1
)

select t.designacao
from t
where t.c in (
  select max(t.c)
  from t
)
order by 1;

--Q8

with t as (
  select c.cod,
    sum(
      case c.sigla
      when 'PD' then c.votos else -c.votos
      end
    ) as s
  from candidato c
  group by 1
)

select t.cod
from t
where t.s > 0
