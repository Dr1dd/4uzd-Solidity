# 4-oji užduotis: išmaniosios sutarties ir decentralizuotos aplikacijos kūrimas

## Kaip įsirašyi ir pasileisti:
Jums prireiks: ```Truffle```, ```Ganache```, ```Metamask```.
 
 Klonuokite repozitoriją.
 
Įsirašykite ``` node.js```

Įveskite ```npm run dev``` į consolę.

``` npm run dev``` iššaukia scriptą, kuris paleidžia ```lite-server``` web serverį.

## 1. Verslo modelis:

Verslo modelyje dalyvauja tokios šalys: ``` Pirkėjas ```, ``` Pardavėjas ```, ``` Registratorius ```

Planas yra toks - Pardavėjas pardavinėja namus, o pirkėjas perka namą. Nusipirkus namą, jis turi būti perregistruojamas ant kito asmens.

Pirkėjas siunčia pardavėjui užklausą namui pirkti. Pardavėjas grąžina atsakymą su nurodyta namo kaina. Pirkėjas patvirtina transakciją ir laukia 

savo namo dokumentų. Tuo tarpu registrų centras gauna žinutę, jog reikia perrašyti namą kitam asmeniui. Dokumentų registruotojas perdavęs 

namo dokumentus naujam savininkui pažymi, jog viskas įvyko sklandžiai. Po patvirtinimo etheriai yra nusiunčiami registruotojui ir buvusiam savininkui.

## 2. Realizuokite pirmąjame žingsnyje aprašytą verslo logiką išmanioje sutartyje Solidyti kalboje.
```contracts/Housing.sol``` faile esantis kodas.

## 3. Ištestuokite išmaniosios sutarties veikimą Ethereum lokaliame tinkle ir Ethereum testiniame tinkle

Testuojant nebuvo rašomas atskiras kodas, bet tiesiog panaudojamas tas pats. 

![img](https://imgur.com/3wlridY.png)

## 4. Etherscan log

Etherscan log'ų pasiekti nepavyko, bet pavyko gauti informaciją iš infura tinklalapio:

![img](https://imgur.com/1qPdC4n.png)

## 5. Sukurkite decentralizuotos aplikacijos Front-Endą (tinklapį arba mobiliąją aplikaciją), kuri įgalintų bendravimą su išmaniąja sutartimi.

Front end:

![img](https://imgur.com/u0LsOwl.png)

![img2](https://imgur.com/W7rRkMl.png)
