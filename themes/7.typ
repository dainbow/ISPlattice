#import "../conf.typ": *

#let rot = $op("rot")$

= О Айтай

#definition(title: "(d, M)-решётка")[
  Пусть заданы натуральное $n$ и вещественные $M > 0, d > 0$. Полная решётка $L subset ZZ^n$, содержащая $(n - 1)$-мерную подрешётку $L'$, для которой выполняются свойства
  + $L'$ имеет базис из векторов, длины которых не более $M$.
  + Если $(n-1)$-мерное подпространство $angle.l L' angle.r = H subset RR^n$ и $H'$ -- сдвиг $H$, неравный ему, имеет непустое пересечение с $L$, то расстояние между $H$ и $H'$ не менее $d$
  называется *(d, M)-решётка*.
]

#proposition(title: "Генерация ключей")[
  + Порождаем $(n - 1)$-мерную решётку $L'$ с базисом $(b_1, ..., b_(n - 1))$ с условием $norm(b_i) <= M$. Пусть $H$ -- линейная оболочка $L'$.
  + Выбираем $d >= n^C M$
  + Выбираем из большого куба случайный вектор $b_n$ с расстоянием $d <= d_L <= 2d$ от H
  + Секретный ключ -- вектор $b_n^*$
  + Открытый ключ -- случайный базис $B'$ в
  #eq[
    $L = L(b_1, ..., b_n)$
  ]
]

#proposition(title: "Алгоритм шифрования")[
  Вход: сообщение $x$, $i$-й бит которого равен $x_i$.

  Выход: набор $Y$ векторов, $i$-й вектор которого $y_i = (y_1^i, ..., y_n^i)$ такой, что $y_j^i = z_j^i / n$, где $z_j^i$ -- целое.

  Выполнение:

  Для каждого бита $x_i = 1$ сообщения x выбираем случайный вектор $y^i = (y^i_1, ..., y^i_n)$ в соответствии с равномерным распределением в параллелепипеде $cal(P)(b_1^*, ..., b_n^*)$.

  Для каждой координаты $y_j^i$ вектора $y_i$ вычисляем её рациональное приближение $tilde(y)^i_j = z_j^i / n$, такое, что $abs(y^i_j - tilde(y)^i_j) < 1 / n$.

  Биту $x_i = 0$ сообщения ставим в соответствие сумму случайного вектора $z_i in RR^n$, выбранного в соответствии с нормальным распределением с функцией плотности
  #eq[
    $rho(w) = e^(-pi norm(w)^2), w in RR^n$
  ]
  Вектор $z_i$ определяет единственный элемент $y_i in cal(P)(b_1^*, ..., b_n^*)$, такой, что $y_i - z_i in L$. Для каждой координаты $y^i_j$ вектора $y_i$ также вычисляется его рациональное приближение.
]

#proposition(title: "Алгоритм дешифрования")[
  Через $[[x]]$ обозначим расстояние до ближайшего целого к $x$.

  Вход: Набор $Y$, векторов $y_i$.

  Выход: Последовательность $x'$ битов $x'_i$.

  Выполнение:

  Для всех $i$ находим скалярное произведение $alpha_i = (y_i, b_n^*)$. Если $[[alpha_i]] >= tilde(c) sqrt(log n)$, то получаем бит $x_i' = 1$, иначе -- 0.
]

#proposition(title: "Алгебраический NTRU")[
  Элементы кольца
  #eq[
    $R = ZZ[X] / (X^n - 1)$
  ]
  будем представлять многочленом или вектором в $ZZ^n$ вида
  #eq[
    $f = sum_(i = 0)^(n - 1) f_i X^i = [f_0, f_1, ..., f_(n - 1)]$
  ]
  Произведение в этом кольце описывается формулой
  #eq[
    $f * g = [f_0, f_1, ..., f_(n - 1)] * [g_0, g_1, ..., g_(n - 1)] = [h_0, h_1, ..., h_(n - 1)]$
  ]
  где
  #eq[
    $h_k = sum_(i = 0)^k f_i g_(k - i) + sum_(i = k + 1)^(n - 1) f_i g_(n + k - i)$
  ]
  Пусть $p$ и $q$ -- два небольших взаимно простых числа. В кольцах $R_p = R / (p)$ и $R_q = R / (q)$ коэффиценты многочленов представляются остатками в диапазонах $[0, p - 1]$ и $[0, q - 1]$.

  Рассмотрим также множество многочленом $cal(P)_p (N)$, коэффициенты которого уже $in (-p / 2, p / 2]$
]

#proposition(title: "Генерация ключа")[
  Выбираем два случайных многочлена $f, g in R$ с маленькими коэффициентами (например, из множества ${-1, -, 1}$) и взаимно простые числа $p, q$ такие, что для многочлена $f$ существуют обратные элементы $f_p^(-1)$ и $f_q^(-1)$ в кольцах $R_p, R_q$ соответственно.

  С вероятностью близкой к единице, случайный многочлен $f$ удовлетворяет этому условию. Причём обратные элементы строятся с помощью алгоритма Евклида.

  Затем вычисляется многочлен $h$ в $R_q$:
  #eq[
    $h equiv p f_q^(-1) * g mod q$
  ]
  Открытым ключом шифрования объявляется многочлен $h$ и числа $q, p$. Секретным ключом -- пара $f, g$.
]

#proposition(title: "Шифрование")[
  Пусть имеется пара -- текст $m$ (предполагаем, что текст представляет собой многочлен с маленькими коэффициентами, например, ${-1, 0, 1}$) и случайный вектор $r$.

  Тогда зашифрованный текст $t$ получается по формуле
  #eq[
    $t equiv r * h + m mod q$
  ]
]

#proposition(title: "Дешифрация")[
  Пусть $t$ -- шифртекст и $f$ -- секретный ключ. Сначала вычислим многочлен $a$ по формуле
  #eq[
    $a equiv f * t mod q$
  ]
  причём коэффициенты многочлена $a$ выбираются из интервала $(-q / 2, q / 2]$. Рассматривая многочлен $a$ как многочлен с целыми коэффициентами, вычислим многочлен $m' in R_p$ по формуле
  #eq[
    $m' = f^(-1)_p * a mod p$
  ]
]

#definition[
  Целочисленная решётка, содержащая решётку $q ZZ^n$ называется *$q$-модулярной*.
]

#definition[
  Вектор $(x_n, x_1, ..., x_(n - 1))$ называется *циркулянтом* вектора $x = (x_1, ..., x_n)$ и обозначается $rot(x)$
]

#definition[
  Пусть $x, y in ZZ^n$ и $z = (x, y) in ZZ^(2 n)$. Определим *бициркулянт* формулой
  #eq[
    $rot_2 (z) = (rot(x), rot(y))$
  ]
]

#definition[
  Целочисленная решётка $cal(L)$ размерности $2 n$ называется *бициклической*, если из $x in cal(L)$ следует, что $rot_2 (x) in cal(L)$.
]

#lemma[
  Пересечение сохраняет свойства $q$-модулярности и бицикличности. В частности, для любого множества векторов $S$ определена минимальная $q$-модулярная бициклическая решётка, содержащая множество $S$.
] <vectors_to_lattice>

#definition[
  Квадратная невырожденная матрица $A in ZZ^(n times n)$ называется *эрмитовой*, если
  - $A$ верхнетреугольная матрица
  - Все диагональные элементы матрицы $A$ строго положительны
  - Все недиагональные элементы приведены по модулю соответствующего диагонального элемента в той же строке
]

#proposition(title: "Генерация ключей")[
  Секретный ключ определяется коротким вектором
  #eq[
    $v = (x_1 p, ..., x_n p, y_1, ..., y_n) quad x_i, y_i in {-1, 0, 1}$
  ]
  Свяжем с этим вектором бициклическую $q$-модулярную решётку по @vectors_to_lattice.

  Порождающим множеством этой решётки являются бицеркулянты вида $rot_2^k (v)$ для всех $k = 0, .. n - 1$ и множество векторов вида $q e_k, k = 1, ..., 2n$.

  Открытый ключ определяется, как эрмитов нормальный базис бициклической $q$-модулярной решётки, определяемой вектором $v$.
]

#proposition(title: "Шифрование/Дешифрование")[
  Рассмотрим вектор $(m , -r)$. При приведении этого вектора по модулю эрмитова нормального базиса $H$ получим шифротекст $(t, 0)$, где $t$ -- многочлен из определения шифрования с помощью многочленов.

  Алгоритм дешифрования не имеет геометрической интерпретации и выполняется по ранее описанным формулам.
]

