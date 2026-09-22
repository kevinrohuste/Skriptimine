for arv in range(1000, 10000):
    hetke_summa = arv

    while hetke_summa > 9:
        summa = 0
        temp = hetke_summa

        while temp > 0:
            summa += temp % 10
            temp //= 10

        hetke_summa = summa

    if hetke_summa == 7:
        print(arv)
