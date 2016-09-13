function h = circle2(x,y,r)

    d = r*2;

    px = x-r;

    py = y-r;

    h = rectangle('Position',[px py d d],'Curvature',[1,1]);

    daspect([1,1,1])
