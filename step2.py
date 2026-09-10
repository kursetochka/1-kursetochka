from matplotlib import pyplot 
from math import sin, cos, pi
with open('C:/Users/User/Downloads/res.txt') as f1, open('C:/Users/User/Downloads/coeff5.csv') as f2:
    res = [[float(j) for j in i.strip('\n').split(',')] for i in f1.readlines()[1:]]
    coeff = list(map(float, f2.read().strip('\n').split(',')))
    x_points = []
    y_points = []
    def x(t):
        return (1 + coeff[0] * cos(t) + coeff[1] * cos(2 * t)) * cos(t)
    def y(t):
        return (1 + coeff[0] * sin(t) + coeff[2] * sin(2 * t)) * sin(t)
    t = 0
    while t <= 2 * pi:
        x_points.append(x(t))
        y_points.append(y(t))
        t += 0.01
    fig = pyplot.figure() # создаем пустой лист и сохраняем объект - график в переменную fig

    # 111 разделяет лист на 1 строку и 1 столбец и помещает туда 1 график
    # projection='3d' создает 3D систему (по умолчанию стоит 2D)

    ax = fig.add_subplot(111, projection='3d') 
    ax.plot(x_points, y_points, [0] * len(x_points), 'b') # ax.plot сопоставляет точки x_i, y_i, z_i и соединяет их
    for i in res:
        r = i[0]
        ax.plot([i[1], i[3]], [i[2], i[4]], [0, 0], 'g')
        ax.plot([i[5], i[7]], [i[6], i[8]], [0, 0], 'r')
        middle_x = (i[1] + i[3]) / 2
        middle_y = (i[2] + i[4]) / 2
        ax.plot([middle_x], [middle_y], [r], 'ko') # 'ko' = 'k' - черный, 'o' - круглый маркер
    ax.set_xlabel('x') 
    ax.set_ylabel('y') 
    ax.set_zlabel('z')
    pyplot.savefig('C:/Users/User/Downloads/result2.pdf') 
    pyplot.show()
