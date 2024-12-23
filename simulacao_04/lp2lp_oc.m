%% Copyright (C) 2021 Tony Richardson
%%
%% This program is free software: you can redistribute it and/or modify
%% it under the terms of the GNU General Public License as published by
%% the Free Software Foundation, either version 3 of the License, or
%% (at your option) any later version.
%%
%% This program is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.
%%
%% You should have received a copy of the GNU General Public License
%% along with this program.  If not, see <https://www.gnu.org/licenses/>.

%% -*- texinfo -*-
%% @deftypefn {} {@var{[B, A]} =} lp2lp (@var{Bp}, @var{Ap}, @var{wa})
%% Transform a lowpass s-plane filter into another s-plane 
%% lowpass filter with a different cutoff frequency.
%% @seealso{lp2hp, lp2bp, lp2bs}
%% @end deftypefn

%% Author: Tony Richardson <richardson.tony@gmail.com>
%% Created: 2021-04-09

function [B, A] = lp2lp_oc(Bp, Ap, wa)
  [z p k] = tf2zp(Bp, Ap);
  [z p k] = sftrans(z, p, k, wa, false);
  [B A] = zp2tf(z, p, k);
end

%!demo
%! [z p k] = cheb1ap(8, 3);
%! [b a] = zp2tf(z, p, real(k));
%!
%! Wo = 2*pi*30;
%! [bt at] = lp2lp(b, a, Wo);
%!
%! w = logspace(-2, 1, 501);
%! H = freqs(b, a, w);
%! figure(1)
%! clf
%! subplot(2, 1, 1)
%! loglog(w, abs(H))
%! grid on
%! subplot(2, 1, 2)
%! semilogx(w, rad2deg(angle(H)))
%! grid on
%!
%! w = logspace(0, 3, 501);
%! H = freqs(bt, at, w);
%!
%! figure(2)
%! clf
%! subplot(2, 1, 1)
%! loglog(w, abs(H))
%! grid on
%! subplot(2, 1, 2)
%! semilogx(w, rad2deg(angle(H)))
%! grid on
