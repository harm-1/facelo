import matplotlib.pyplot as plt
from scipy.stats import binom

n = 10
k_range = range(n+1)
u_factor = 8/9
p_b = (1/2)**n

result = []
result_pmf = []
result_comb = []
result_perc_check = []
for k in k_range:
    p_u = u_factor**k * (1-u_factor)**(n-k)
    P_user = p_u / (p_u + p_b)

    bino = binom.pmf(k, n, u_factor)

    result.append(P_user)
    result_pmf.append(bino)
    result_comb.append(P_user * bino)
    if P_user > 0.1:
        result_perc_check.append(bino)

print(result)
print(sum(result_comb))
print(sum(result_perc_check))

# plt.plot(result)
# plt.show()

# plt.plot(result_pmf)
# plt.show()

# plt.plot(result, result_pmf)
# plt.show()

plt.plot(result_perc_check)
plt.show()
