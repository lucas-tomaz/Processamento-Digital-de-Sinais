
fs = 44100

Ts = 1/fs

Wp = 2*2300*Ts
Ws = 2*3000*Ts
Gp = 0.1
Gs = 30

[N, w0] = buttord(Wp, Ws, Gp, Gs)

[B,A] = butter(N, 1, 's')

w0 = w0*pi/Ts

[b,a] = lp2lp_oc(B,A,w0)

[bt, at] = bilinear(b,a,Ts)

freqz(bt, at)


