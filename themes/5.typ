#import "../conf.typ": *

= О ACVP

#definition(title: "Задача ACVP")[
  Пусть задан вектор $b in RR^m$ и $n$-мерная решётка с базисом $(b_1, ..., b_n)$.

  Требуется найти вектор $b_0 in angle.l b_1, ..., b_n angle.r$, для которого выполнено соотношение.

  #eq[
    $norm(b - b_0) <= 2 (2 / sqrt(3))^n min_(x in angle.l b_1, ..., b_n angle.r) norm(x - b)$
  ]
]

#definition(title: "ACVP-алгоритм")[
  Вход: Базис решётки $B = (b_1, ..., b_n) in ZZ^(m times n)$ и вектор $t in QQ^m$.

  Выход: решение задачи ACVP.

  В начале нужно выполнить LLL-алгоритм для $delta_n$ (найти LLL-приведённый базис $(p_1, ..., p_n)$ решётки B).

  И в качестве ответа взять вектор
  #eq[
    $sum_(j = 1)^n ceil(((t, p_j^*)) / ((p_j^*, p_j^*))) p_j$
  ]
]

#theorem[
  При $delta_n = (1 / 4) + (3 / 4)^(n / (n - 1))$ ACVP-алгоритм решает задачу ACVP
]

#pagebreak()
