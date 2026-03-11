@echo off
del Interface_old.u
ren Interface.u Interface_old.u

ucc make -NoBind
pause
