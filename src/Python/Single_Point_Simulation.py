
#Import Libraries
from gekko import GEKKO
import numpy as np
import pandas as pd

#Define Constants
R1 = 32*10**(-3); #m
R2 = 16*10**(-3); #m
R3 = 16*10**(-3); #m
L2 = 25*10**(-3); #m
L3 = 25*10**(-3); #m
r = 7850; #kg/m^3
m1 = r*4/3*np.pi*R1**3; #kg
m2 = r*np.pi*R2**2*L2; #kg
m3 = r*np.pi*R3**2*L3; #kg
t1 = 0; #Nm
t2 = 0; #Nm
t3 = 0; #Nm
t4 = 0; #Nm

#Initialize Gekko
m = GEKKO(remote=False)
#Initial Conditions
q1 = m.Var(0)
q2 = m.Var(R3/R1*2*np.pi/9)
q3 = m.Var(0)
q4 = m.Var(R2/R1*np.pi/6)
q5 = m.Var(0)
q6 = m.Var(0)
q7 = m.Var(0)
q8 = m.Var(np.pi/9)
q9 = m.Var(0)
q10 = m.Var(-np.pi/6)
q11 = m.Var(0)
q12 = m.Var(0)
q13 = m.Var(0)
q14 = m.Var(2*np.pi/9)
q15 = m.Var(0)
q16 = m.Var(0)
q17 = m.Var(0)
q18 = m.Var(0)

#Equations of Motion and Constraints
m.Equation(q1.dt()==q2)
m.Equation(q2.dt()*(1-np.sin(q3.value)**2)==5/2/m1/R1*(q18-q15*np.sin(q3.value)*np.cos(q3.value)*np.cos(q1.value)+q16*np.cos(q3.value)*np.sin(q3.value)*np.sin(q1.value)-q17*np.sin(q3.value)*np.cos(q3.value)*np.cos(q1.value)-q18*np.sin(q3.value)**2) + np.sin(q3.value)*np.cos(q3.value)*q4*q2 - np.cos(q3.value)*q4*q6)
m.Equation(q3.dt()==q4)
m.Equation(q4.dt()==5/2/m1/R1*(q15*np.sin(q1.value)+q16*np.cos(q1.value)+q17*np.sin(q1.value)) + np.cos(q3.value)*q2*q6)
m.Equation(q5.dt()==q6)
m.Equation(q6.dt()*(1-np.sin(q3.value)**2)==5/2/m1/R1*(q15*np.cos(q3.value)*np.cos(q1.value)-q16*np.cos(q3.value)*np.sin(q1.value)+q17*np.cos(q3.value)*np.cos(q1.value)) - np.cos(q3.value)*q4*q2 + np.sin(q3.value)*np.cos(q3.value)*q4*q6)
m.Equation(q7.dt()==q8)
m.Equation(q8.dt()==(t1)/(1/4*m2*R2**2+1/12*m2*L2**2))
m.Equation(q9.dt()==q10)
m.Equation(q10.dt()==2/m2/R2*((t2)/R2+q15*np.sin(q7.value)+q16*np.cos(q7.value)))
m.Equation(q11.dt()==q12)
m.Equation(q12.dt()==(t3)/(1/4*m3*R3**2+1/12*m3*L3**2))
m.Equation(q13.dt()==q14)
m.Equation(q14.dt()==2/m3/R3*((t4)/R3+q17*np.sin(q11.value)-q18*np.cos(q11.value)))
m.Equation(R1*np.sin(q1.value)*q4 + R1*np.cos(q3.value)*np.cos(q1.value)*q6 + R2*np.sin(q7.value)*q10==0)
m.Equation(R1*np.cos(q1.value)*q4 - R1*np.cos(q3.value)*np.sin(q1.value)*q6 + R2*np.cos(q7.value)*q10==0)
m.Equation(R1*np.sin(q1.value)*q4 + R1*np.cos(q3.value)*np.cos(q1.value)*q6 + R3*np.sin(q11.value)*q14==0)
m.Equation(R1*q2 + R1*np.sin(q3.value)*q6 - R3*np.cos(q11.value)*q14==0)

#Solver Configuration
m.time = np.linspace(0,3,300)
m.options.IMODE = 4
m.options.NODES = 1
m.options.COLDSTART = 2
m.options.SOLVER = 1
m.options.RTOL = 1e-15
m.options.OTOL = 1e-15
m.solve(disp=False)

#Plots
import matplotlib.pyplot as plt
plt.figure(figsize=(10,5))
plt.subplot(3,1,1)
plt.plot(m.time,q1.value,label='theta')
plt.plot(m.time,q3.value,label='phi')
plt.plot(m.time,q5.value,label='psi')
plt.plot(m.time,q7.value,label='theta_r2')
plt.plot(m.time,q9.value,label='theta_p2')
plt.plot(m.time,q11.value,label='theta_r3')
plt.plot(m.time,q13.value,label='theta_p3')
plt.ylabel('Position')
plt.legend(); plt.grid()
plt.subplot(3,1,2)
plt.plot(m.time,q2.value,label='theta_dot')
plt.plot(m.time,q4.value,label='phi_dot')
plt.plot(m.time,q6.value,label='psi_dot')
plt.plot(m.time,q8.value,label='theta_r2_dot')
plt.plot(m.time,q10.value,label='theta_p2_dot')
plt.plot(m.time,q12.value,label='theta_r3_dot')
plt.plot(m.time,q14.value,label='theta_p3_dot')
plt.ylabel('Velocity')
plt.legend(); plt.grid()
plt.subplot(3,1,3)
plt.plot(m.time,q15.value,label=r'lamda_1')
plt.plot(m.time,q16.value,label=r'lamda_2')
plt.plot(m.time,q17.value,label=r'lamda_3')
plt.plot(m.time,q18.value,label=r'lamda_4')
plt.legend(); plt.grid()
plt.xlabel('Time')
plt.savefig('data.png',dpi=600)
plt.show()

#Data Saving
df = pd.DataFrame()
df['q1'] = np.array(q1)
df['q2'] = np.array(q2)
df['q3'] = np.array(q3)
df['q4'] = np.array(q4)
df['q5'] = np.array(q5)
df['q6'] = np.array(q6)
df['q7'] = np.array(q7)
df['q8'] = np.array(q8)
df['q9'] = np.array(q9)
df['q10'] = np.array(q10)
df['q11'] = np.array(q11)
df['q12'] = np.array(q12)
df['q13'] = np.array(q13)
df['q14'] = np.array(q14)
df['q15'] = np.array(q15)
df['q16'] = np.array(q16)
df['q17'] = np.array(q17)
df['q18'] = np.array(q18)
df.columns = range(df.shape[1])
df.to_excel('data.xlsx', index=False)
