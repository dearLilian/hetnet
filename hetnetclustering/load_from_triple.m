function data = load_from_triple(file)
    X = load(file);
    s = X(1,:);
    l = s(1);
    w = s(2);
%     w = size(X(1,:));
%     l = size(X(:,1));
    for j = 1:1:l
        row = X(j, 1);
        col = X(j, 2);
        value = 1;
        if (w == 3)
            value = X(j, 3);
        end
        %disp(row);
        data(row, col) = value;
    end
end