function [e1,e2,E1_l,E2_l,E1_s1,E2_s2] = pluckerEndpoints(L,s1,s2)

% PLUCKERENDPOINTS  Plucker line and abscissas to endpoints conversion.
%   [E1,E2] = PLUCKERENDPOINTS(L,S1,S2) are the endpoints of the Plucker
%   line L at abscissas S1 and S2.
%
%   [E1,E2,E1_l,E2_l,E1_s1,E2_s2] = PLUCKERENDPOINTS(L,S1,S2) returns the
%   Jacobians wrt the line L and the abscissas S1 and S2.
%
%   See also LS2E, LS2SEG.

v = L(4:6);

if nargout == 1

    vn   = normvec(v);
    p0   = pluckerOrigin(L);
    e1   = p0 + s1*vn;
    e2   = p0 + s2*vn;

else % Jac
    
    [vn,VN_v] = normvec(v,0);
    [p0,P0_l] = pluckerOrigin(L);
    P0_n = P0_l(:,1:3);
    P0_v = P0_l(:,4:6);
    
    e1 = p0 + s1*vn;
    E1_s1 = vn;

    E1_n = P0_n;
    E1_v = P0_v + s1*VN_v;

    E1_l = [E1_n E1_v];

    e2 = p0 + s2*vn;
    E2_s2 = vn;

    E2_n = P0_n;
    E2_v = P0_v + s2*VN_v;

    E2_l = [E2_n E2_v];

end

return

%% jac

syms n1 n2 n3 v1 v2 v3 s1 s2 real
L = [n1;n2;n3;v1;v2;v3];

[e1,e2,E1_l,E2_l,E1_s1,E2_s2] = pluckerEndpoints(L,s1,s2);

simplify(E1_l - jacobian(e1,L))
simplify(E2_l - jacobian(e2,L))
simplify(E1_s1 - jacobian(e1,s1))
simplify(E2_s2 - jacobian(e2,s2))