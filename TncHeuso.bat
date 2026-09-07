@echo off
setlocal enabledelayedexpansion
cls
for /f "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
    set "E=%%b"
)
rem ok hi this is the worst chinese bootleg evah so please make sure you dont cringe to the comments
set house_var_brokie=0
set house_var_bought5K=0
set house_gamevars_deckofcard=0
set house_var_gotbannedfrompact=0
set /p house_var_inpact=< "C:\Users\%username%\.local\thehouse\pact.text"
set "house_games_varInput="
set /p house_global_bal=< "C:\Users\%username%\.local\thehouse\balance.text"
set house_global_goal=0
set "logo=!E![31;43mTnc Heuso -- The Unofficial Batch Port!E![0m"
set "shii=welcome to !logo! v1.6"
cls
reg query HKCU\Software\BlueitySoftware\TheHouseBatch\ /v "runonce1dot4" >nul 2>&1
if %errorlevel% neq 0 (
    echo you've entered the house for the first time.
    ping 127.0.0.1 -n 2 >nul
    echo the house greets you.
    reg add HKCU\SOFTWARE\BlueitySoftware\TheHouseBatch\ /v "runonce1dot4" /d "0" /f
    ping 127.0.0.1 -n 2 >nul
)
if not exist "C:\Users\%username%\.local\thehouse\" (
    echo house var dir doesn't exist
    mkdir "C:\Users\%username%\.local\thehouse\"
    type nul > "C:\Users\%username%\.local\thehouse\balance.text"
    echo 777>"C:\Users\%username%\.local\thehouse\balance.text"
    echo made dir
)
cls
set /p house_global_bal=< "C:\Users\%username%\.local\thehouse\balance.text"
call :house_pages_1

:house_pages_1
cls
echo !shii! (page 1)
echo you have $!house_global_bal!
echo 1 - blackjack
echo 2 - russian roulette
echo 3 - high or low
echo 4 - coinflip
echo 5 - guess the number
echo 6 - plinko
echo 9 - p.a.c.t
echo 10 - shop
echo 99 - next page
echo 0 - exit

set /p "house_var_choice=choose your sin: "
if !house_var_choice! equ 1 (
    goto house_games_blackjack
) else if !house_var_choice! equ 2 (
    goto house_games_roulette
) else if !house_var_choice! equ 3 (
    goto house_games_hi-or-lo
) else if !house_var_choice! equ 4 (
    goto house_games_coinflip
) else if !house_var_choice! equ 5 (
    goto house_games_guessthenum
) else if !house_var_choice! equ 6 (
    goto house_games_plinko
) else if !house_var_choice! equ 9 (
    goto house_misc_pact
) else if !house_var_choice! equ 10 (
    goto house_misc_shop
) else if !house_var_choice! equ 0 (
    echo please exit via the x command
    pause 
    call :eof
) else if !house_var_choice! equ 99 (
    call :house_pages_2
) else (
    echo invalid input!
    pause
    call :house_pages_1
)

:house_pages_2
cls
echo !shii! (page 2)
echo you have $!house_global_bal!
echo 1 - test game thingy
echo 2 - update logs
echo 99 - previous page
echo 0 - exit

set /p "house_var_choice=choose your sin: "
if !house_var_choice! equ 0 (
    echo please exit via the x command
    pause 
    call :eof
) else if !house_var_choice! equ 1 (
    goto house_games_template
) else if !house_var_choice! equ 2 (
    goto house_misc_updatelogs
) else if !house_var_choice! equ 99 (
    call :house_pages_1
) else (
    echo invalid input!
    pause
    goto house_pages_2
)
:house_misc_updatelogs
cls
echo update logs:
echo -- v1.5 (INITIAL GITHUB RELEASE??? :O) --
echo so i decided to find this lost media and attempted to suit this sorcery (a.k.a. a batch port with bugged stuff)
echo dont forget to leave issues for useless nonsense you wanna yap that kicks you out becuase most of the code has NOT been optimized
echo to a specific windows version
echo a great part of this version was tested on proton-ge (fork of gabe newell's proton fork of winehq's wine) so mind the mistakes on actual windows (i.e. 10/11)
echo anyways The House: Batch Edition has been renamed to !logo! to reflect all the big brand phone chinese bootlegs like this
pause
echo leaving...
call :house_pages_2


:house_misc_pact
    cls
    if !house_var_inpact! equ true (
        echo you've already signed the pact
        ping -n 2 127.0.0.1 >nul
        echo bit greedy, dont ya think?
        ping -n 3 127.0.0.1 >nul
    ) else (
        type nul > C:\Users\%username%\.local\thehouse\pact.text
        echo the pact is offered to you.
        ping -n 2 127.0.0.1 >nul
        echo your balance will be multiplied by 5
        ping -n 2 127.0.0.1 >nul
        echo but one loss, and your balance is set to 1 measly dollar
        ping -n 3 127.0.0.1 >nul
        set /p "house_games_varInput=do you accept the pact [y/n]: "
        if /i "!house_games_varInput!" equ "y" (
            set /a house_global_bal=house_global_bal*5
            echo !house_global_bal!>"C:\Users\%username%\.local\thehouse\balance.text"
            echo true>"C:\Users\%username%\.local\thehouse\pact.text"
            set /p house_var_inpact= < "C:\Users\%username%\.local\thehouse\pact.text"
            echo your balance is now !house_global_bal!
            ping -n 3 127.0.0.1 >nul
            echo watch your back
            ping -n 2 127.0.0.1 >nul
        ) else (
            echo you walk away, the house watches.
            ping -n 3 127.0.0.1 >nul
        )
    )
    set /p house_var_inpact= < "C:\Users\%username%\.local\thehouse\pact.text"
    goto house_pages_1

:house_misc_setgoal
echo.
set /p "house_misc_goalvar=place your bet (you have !house_global_bal!): "
if !house_misc_goalvar! gtr !house_global_bal! (
    echo you cant bet more than your balance!
    pause
    goto house_misc_setgoal
) else if !house_misc_goalvar! lss 1 (
    echo you cant bet less than 1!
    pause
    goto house_misc_setgoal
) else (
    set /a house_global_goal=house_misc_goalvar
    goto :eof
)

:house_games_blackjack
call :house_misc_setgoal
cls
echo welcome to hell (blackjack)
echo h = hit  s = stand  d = double down
echo (h/s/d)
set /p "house_games_varInput=what are you gonna do? "

set /a choice=!RANDOM! %% 3 + 1
if !choice! equ 1 set "house_var_blackJackBlack=hit"
if !choice! equ 2 set "house_var_blackJackBlack=stand" 
if !choice! equ 3 set "house_var_blackJackBlack=double down"

echo you choose !house_games_varInput!
ping -n 1 127.0.0.1 >nul
echo dealer shows: !house_var_blackJackBlack!
echo ...
ping -n 3 127.0.0.1 >nul
goto house_games_losehandler

:house_games_roulette
call :house_misc_setgoal
cls
echo welcome to russian roulette
echo s = shoot  n = dont shoot
echo (s/n)
set /p "house_games_varInput=what are you gonna do? "

echo you !house_games_varInput!...
echo ...
ping -n 3 127.0.0.1 >nul
goto house_games_losehandler

:house_games_hi-or-lo
call :house_misc_setgoal
cls
echo welcome to high or low
set /a house_gamevars_hiorloval=!RANDOM! %% 13 + 1
set /a house_gamevars_deckofcard=house_gamevars_deckofcard+1
echo starting card is !house_gamevars_deckofcard!
set /p "house_games_varInput=will the next card become higher or low? (h/l): "

echo ...
ping -n 3 127.0.0.1 >nul
goto house_games_losehandler


:house_games_coinflip
call :house_misc_setgoal
cls
echo welcome to coinflip
set /p "house_games_varInput=heads or tails? (h/t): "
echo ...
ping -n 3 127.0.0.1 >nul
goto house_games_losehandler


:house_games_guessthenum
call :house_misc_setgoal
set /a house_var_gtnAtt=0
set /a house_var_gtnTgt=!RANDOM! %% 100 + 1
cls
echo welcome to guess the number
echo i picked a number between 1 and 100. you have 6 tries to guess it

:house_loops_guessthenum
if !house_var_gtnAtt! geq 7 (
    echo you ran out of attempts. the number was !house_var_gtnTgt!.
    ping -n 2 127.0.0.1 >nul
    goto house_misc_lose
)

set /p "house_games_varInput=attempt !house_var_gtnAtt!: your guess? "

echo !house_games_varInput!|findstr /r "^[0-9][0-9]*$" >nul
if errorlevel 1 (
    echo please type a number.
    goto house_loops_guessthenum
)

if !house_games_varInput! lss 1 (
    echo guess out of range
    goto house_loops_guessthenum
)
if !house_games_varInput! gtr 100 (
    echo guess out of range
    goto house_loops_guessthenum
)

if !house_games_varInput! equ !house_var_gtnTgt! (
    call :house_misc_win gtn
    goto house_pages_1
)

if !house_games_varInput! lss !house_var_gtnTgt! (
    echo too low
) else (
    echo too high
)

set /a house_var_gtnAtt=house_var_gtnAtt+1
goto house_loops_guessthenum

:house_games_plinko
call :house_misc_setgoal
cls
echo welcome to plinko
echo we are dropping the ball
ping -n 2 127.0.0.1 >nul

set /a house_var_funny_plinkorows=12
set /a house_var_funny_plinkoslots=6
set /a house_var_funny_plinkopos=house_var_funny_plinkoslots/2
for /L %%r in (1,1,%house_var_funny_plinkorows%) do (
    set /a house_var_funny_plinkomv=!random! %% 3 - 1
    set /a house_var_funny_plinkopos+=!house_var_funny_plinkomv!
    if !house_var_funny_plinkopos! lss 0 set house_var_funny_plinkopos=0
    if !house_var_funny_plinkopos! gtr %house_var_funny_plinkoslots%-1 set house_var_funny_plinkopos=%house_var_funny_plinkoslots%-1
    cls
    echo frame %%r
    for /L %%y in (0,1,%%r) do (
        set "house_var_funny_plinkoln="
        for /L %%x in (0,1,%house_var_funny_plinkoslots%-1) do (
            set "ball=."
            if %%y==%%r if %%x==!house_var_funny_plinkopos! set "ball=o"
            set "house_var_funny_plinkoln=!house_var_funny_plinkoln!!ball! "
        )
        echo !house_var_funny_plinkoln!
    )
    ping -n 1 -w 300 127.0.0.1 >nul
)

echo.
echo the ball landed in: slot !house_var_funny_plinkopos!
ping -n 2 127.0.0.1 >nul
if !house_var_funny_plinkopos! equ %house_var_funny_plinkoslots%/2 (
    call :house_misc_win
) else if !house_var_funny_plinkopos! geq 2 if !house_var_funny_plinkopos! leq 4 (
    set /a house_global_bal=!house_global_bal!*!house_var_funny_plinkopos!/2
    echo you win (current balance: !house_global_bal! )
    ping -n 2 127.0.0.1 >nul
    goto house_pages_1
) else (
    call :house_misc_lose
)
goto house_pages_1

:house_games_template
call :house_misc_setgoal
cls
echo welcome to [TEMPLATE GAME]
set /p "house_games_varInput=input [a/b/c]: "
echo ...
ping -n 3 127.0.0.1 >nul
goto house_games_win

:house_misc_shop
cls
echo welcome to !logo! shop! here you will find everything you need
echo you have $!house_global_bal!.
echo 1 -- get-out-of-the-p.a.c.t-card - $30000
echo 2 -- sold-out
echo 3 -- crash-card (take a wild guess) - $2500
echo 4 -- 5k-deposit (a sort of insurance when you go broke) - $5000
echo 0 -- exit

set /p "house_var_shopInp=buy something: "

if "!house_var_shopInp!" equ "1" (
    if !house_global_bal! geq 30000 (
        if !house_var_inpact! equ true (
            set house_var_inpact=false
            echo !house_var_inpact!>"C:\Users\%username%\.local\thehouse\pact.text"
	    echo you left the pact
            set /a house_global_bal=house_global_bal-30000
            pause
            goto house_pages_1
        ) else (
            echo you're not in the pact.
            pause
            goto house_pages_1
        )
    ) else (
        echo you are too broke to buy this.
        pause
        goto house_pages_1
    )
) else if "!house_var_shopInp!" equ "2" (
    echo its sold out.
    pause
    goto house_misc_shop
) else if "!house_var_shopInp!" equ "3" (
    if !house_global_bal! geq 2500 (
        echo you use the crash card
        ping -n 2 127.0.0.1 >nul
        echo nothing happens-
        exit /b 0
    ) else (
        echo you're too broke mr brochachie
        pause
        goto house_pages_1
    )
) else if "!house_var_shopInp!" equ "4" (
    if !house_global_bal! geq 5000 (
        echo you cash in your 5k deposit!
        set house_var_bought5K=1
        set /a house_global_bal=house_global_bal-5000
        pause
        goto house_pages_1
    ) else (
        echo you is borke
        pause
        goto house_pages_1
    )
) else if "!house_var_shopInp!" equ "0" (
    goto house_pages_1
)

goto house_misc_shop

:house_misc_win
if "%~1" equ "gtn" (
    echo correct, you win !E![30;47m!E![32m+!house_global_goal! balance!E![0m
) else (
    echo you win :D !E![30;47m!E![32m+!house_global_goal! balance!E![0m
)
set /a house_global_bal=house_global_bal+house_global_goal
echo !house_global_bal!>"C:\Users\%username%\.local\thehouse\balance.text"
ping -n 2 127.0.0.1 >nul
goto house_pages_1

:house_misc_lose
if !house_var_inpact! neq true (
    set /a house_global_bal=house_global_bal-house_global_goal
    echo !house_global_bal!>"C:\Users\%username%\.local\thehouse\balance.text"
    echo you lose... 
    echo your current balance is !house_global_bal!
    ping -n 3 127.0.0.1 >nul
    goto house_pages_1
) else (
    echo you lose...
    echo pact - your money belongs to us!!! mwahahahahahahaaaah
    ping -n 4 127.0.0.1 >nul
    set house_global_bal=1
    echo !house_global_bal!>"C:\Users\%username%\.local\thehouse\balance.text"
    goto house_pages_1
)

:house_games_losehandler
set /a result=!RANDOM! %% 2
if !result! equ 1 (
    goto house_misc_win
) else (
    goto house_misc_lose
)
