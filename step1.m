coeff = csvread('C:/Users/User/Downloads/coeff5.csv');
x = @(t) (1 + coeff(1) * cos(t) + coeff(2) * cos(2 * t)) * cos(t);
y = @(t) (1 + coeff(1) * sin(t) + coeff(3) * sin(2 * t)) * sin(t);
function res = search(r, x, y)
  points = [];
  res = [];
  eps = 0.01;
  step = 0.01;
  for t1 = 0:step:2 * pi
    for t2 = t1 + step:step:2 * pi
      if abs(sqrt((x(t2) - x(t1)) ^ 2 + (y(t2) - y(t1)) ^ 2) - r) < eps
        points(end + 1, :) = [x(t1), y(t1), x(t2), y(t2)];
      endif
    endfor
  endfor
  for i = 1:size(points, 1)
    for j = i + 1:size(points, 1)
      flag = true;
      counter1 = 0;
      counter2 = 0;
      for c = 1:4
        if abs(points(i, c) - points(j, c)) < eps
          counter1 = counter1 + 1;
        endif
        if abs(points(i, c) - points(j, mod(c + 1, 4) + 1)) < eps
          counter2 = counter2 + 1;
        endif
      endfor
      if counter1 == 4 || counter2 == 4
        flag = false;
      endif
      if flag && abs((points(i, 1) + points(i, 3)) / 2 - (points(j, 1) + points(j, 3)) / 2) < eps && abs((points(i, 2) + points(i, 4)) / 2 - (points(j, 2) + points(j, 4)) / 2) < eps
        res(end + 1, :) = [points(i, :), points(j, :)];
        return
      endif
    endfor
  endfor
endfunction
f = fopen('C:/Users/User/Downloads/res.txt', 'w');
fprintf(f, 'r, x11, y11, x12, y12, x21, y21, x22, y22\n');
for r = 0.5:0.5:3
  res = search(r, x, y);
  if !isempty(res)
    fprintf(f, '%f, %f, %f, %f, %f, %f, %f, %f, %f\n', r, res(:, 1), res(:, 2), res(3), res(4), res(5), res(6), res(7), res(8));
  endif
endfor
fclose(f);
