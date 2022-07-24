<p align="center"><a href="https://bearsampp.com" target="_blank"><img width="100" src="https://github.com/Bearsampp/prerequisites/blob/main/img/Bearsampp-logo.png"></a></p>
<p align="center">Bearsampp Prerequisites Package</p>

<p align="center">
  <a href="https://github.com/bearsampp/prerequisites/releases/latest"><img src="https://img.shields.io/github/release/bearsampp/prerequisites.svg?style=flat-square" alt="GitHub release"></a>
  <img src="https://img.shields.io/github/downloads/bearsampp/prerequisites/total.svg?style=flat-square" alt="Total downloads">
  <a href="https://github.com/sponsors/N6REJ"><img src="https://img.shields.io/badge/sponsor-N6REJ-181717.svg?logo=github&style=flat-square" alt="Become a sponsor"></a>
  <a href="https://www.paypal.me/BearLeeAble"><img src="https://img.shields.io/badge/donate-paypal-00457c.svg?logo=paypal&style=flat-square" alt="Donate Paypal"></a>
</p>

## About
This a sub-repo involving prerequisites required before any use of [Bearsampp project](https://github.com/bearsampp).
<br />
Issues must be reported on [Bearsampp repository](https://github.com/bearsampp/bearsampp/issues).

### Visual C++ Redistributables
The MSVC runtime libraries VC9, VC10, VC11 are no longer supported by Microsoft.<br />
Runtimes VC13, VC14 are required for PHP 7, Apache 2.4.17 and PostgreSQL.<br />
Runtimes vc15 vc16 & vc17 are required for php8, apache 2.4.51 and the latest Postgresql.<br>
This package provides all the Visual C++ Redistributables required for Bearsampp :

* Visual C++ 2012 UPD4 Runtimes (VC11) ([x86 / x64](http://www.microsoft.com/en-US/download/details.aspx?id=30679))
* Visual C++ 2013 Runtimes (VC13) ([x86 / x64](https://www.microsoft.com/en-US/download/details.aspx?id=40784))
* Visual C++ 2015-2022 Runtimes (VC14 VC15 VC16 vc17) ([x86](https://aka.ms/vs/17/release/vc_redist.x86.exe) / [x64](https://aka.ms/vs/17/release/vc_redist.x64.exe))

### Additionnal KBs
* [KB838079](http://support.microsoft.com/kb/838079) : Integrated for Windows XP to install [Windows Support Tools](http://www.microsoft.com/en-us/download/details.aspx?id=18546).
* [KB2731284](http://support.microsoft.com/kb/2731284) : Fix "33" DOS error code when memory memory-mapped files are cleaned by using the FlushViewOfFile() function in Windows 7.

## License
LGPL-3.0. See `LICENSE` for more details.<br />
