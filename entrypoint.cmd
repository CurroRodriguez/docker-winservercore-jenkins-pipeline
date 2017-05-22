@echo off
mkdir %USERPROFILE%\.ssh
ssh-keygen -f %USERPROFILE%\.ssh\id_rsa -t rsa -N ''
cls
cmd /S /C %1
