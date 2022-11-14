apt = proc{|package|
  info = `dpkg -s #{package}`
  ver = info[/Version: (\d:)?(.*)/, 2]
  r = "Debian package: #{package}-" + ver
  if info =~ /^Homepage: (.*)/
    r += " (#{$1})"
  end
  r
}

LANGS = {
  'rb' => [apt['ruby1.8']],
  'rb2' => [apt['ruby2.2']],
  'pl' => [apt['perl']],
  'py' => [apt['python']],
  'py3' => [apt['python3']],
  'php' => [apt['php5-cli']],
  'scm' => [apt['gauche']],
  'l' => [apt['clisp']],
  'arc' => ['arc3.tar (http://arclanguage.org/)'],
  'ly' => [apt['lilypond']],
  'io' => ['Io 20080209 (http://iolanguage.com/)'],
  'js' => [apt['spidermonkey-bin']],
  'lua' => [apt['lua5.1']],
  'tcl' => [apt['tcl8.5']],
  'xtal' => ['xtal 0.9.7.0 (http://code.google.com/p/xtal-language/)'],
  'kt' => ['This is kite, version 1.0.3 (http://www.kite-language.org/)'],
  'cy' => ['cyan-1.0.3.tgz (http://www.geocities.jp/takt0_h/cyan/index.html)'],
  'st' => [apt['gnu-smalltalk']],
  'pro' => [apt['swi-prolog']],
  'for' => [apt['gforth']],
  'bas' => [apt['yabasic']],
  'pl6' => ['This is Rakudo Perl 6. (http://rakudo.org/)',
            'We are using <a href="https://github.com/rakudo/rakudo/commit/7a9a4cadeb3704b659505bc5c12c3e115797a4d4">this version</a>.'],
  'erl' => [apt['erlang']],
  'ijs' => ['j602a (http://www.jsoftware.com/)'],
  'a+' => [apt['aplus-fsf']],
  'mind' => ['Mind Version 7 for UNIX mind7u06.tar.gz (http://www.scripts-lab.co.jp/mind/whatsmind.html)'],
  'c' => [apt['gcc']],
  'cpp' => [apt['g++']],
  'd' => ['Digital Mars D Compiler v2.019 (http://www.digitalmars.com/d/)'],
  'di' => ['Digital Mars D Compiler v1.047 (http://www.digitalmars.com/d/)'],
  # cd /golf/local/go && hg log | head -4
  'go' => ['go version go1.9.2 linux/386 (http://golang.org/)'],
  'ml' => [apt['ocaml']],
  'hs' => [`ghc-8.0.2 --version`],
  'adb' => [apt['gnat']],
  'm' => [apt['gobjc']],
  'java' => [apt['sun-java6-jdk']],
  'pas' => [apt['gpc']],
  'f95' => [apt['gfortran']],
  'cs' => [apt['mono-gmcs']],
  'n' => [apt['nemerle']],
  'cob' => [apt['open-cobol']],
  # cyc -v
  'curry' => ['cyc version 0.9.11 (built on Mon Jun 11 10:35:49 CEST 2007) (http://www.curry-language.org/)'],
  'lmn' => ['lmntal-20080828 (http://www.ueda.info.waseda.ac.jp/lmntal/pukiwiki.php?LMNtal)'],
  'max' => [apt['maxima']],
  'reb' => ['rebol-276 (http://www.rebol.com/)'],
  'asy' => [apt['asymptote']],
  'awk' => [apt['mawk']],
  'sed' => [apt['sed']],
  'sh' => [apt['bash']],
  'bash' => [apt['bash']],
  'xgawk' => ['Extensible GNU Awk 3.1.6 (build 20080101) with dynamic loading, and with statically-linked extensions (http://sourceforge.net/projects/xmlgawk)'],
  'm4' => [apt['m4']],
  'ps' => [apt['ghostscript']],
  'r' => [apt['r-base']],
  #'vhdl' => [apt['ghdl']],
  'vhdl' => ['broken probably :('],
  'qcl' => ['qcl-0.6.3 (http://tph.tuwien.ac.at/~oemer/qcl.html)'],
  'bf' => ['http://en.wikipedia.org/wiki/Brainfuck',
           'I think we are using <a href="http://esoteric.sange.fi/brainfuck/impl/interp/BFI.c">this C interpreter</a>, but I\'m not sure...'],
  'bfsl' => ['c6820766108596ba522d64b6d8581f5bbb4e526b (https://github.com/yshl/MNNBFSL)'],
  'gs2' => ['827ade5d5f7ed8c690bb23724dd13df613fbf702 (https://github.com/nooodl/gs2)'],
  'ws' => ['http://compsoc.dur.ac.uk/whitespace/',
           'We are using <a href="http://compsoc.dur.ac.uk/whitespace/downloads/wspace-0.3.tgz">the Haskell interpreter</a>.'],
  'bef' => ['http://catseye.tc/projects/bef/',
            'We are using <a href="http://catseye.tc/projects/bef-2.21.zip">the reference implementation</a>.'],
  'bef98' => ['http://users.tkk.fi/~mniemenm/befunge/ccbi.html',
            'We are using CBBI-2.1.'],
  'pef' => ['http://d.hatena.ne.jp/ku-ma-me/searchdiary?word=pefunge',
            'Pefunge is an esoteric language proposed by mame. There is only Japanese documentation about this language. <a href="http://dame.dyndns.org/misc/pefunge/2dpi.rb">The reference implementation</a>.'],
  'ms' => ['http://www.golfscript.com/minus/',
           'Minus is an esoteric language, with only 1 instruction operator, invented by flagitious.'],
  'gs' => ['http://www.golfscript.com/golfscript/',
           'GolfScript is a stack oriented esoteric language invented by flagitious.'],
  'flog' => ['http://esolangs.org/wiki/FlogScript'],
  'nand' => ['http://esolangs.org/wiki/FerNANDo',
            'We are using the Python implementation 0.5.'],
  'unl' => ['http://www.madore.org/~david/programs/unlambda/',
            'We are using <a href="http://www.math.cas.cz/~jerabek/unlambda/unl.c">the C interpreter</a> written by Emil Jerabek.'],
  'lazy' => ['http://homepages.cwi.nl/~tromp/cl/lazy-k.html',
             'We are using <a href="http://kiritanpo.dyndns.org/lazyk.c">the C interpreter</a> written by irori.'],
  'grass' => ['http://www.blue.sky.or.jp/grass/',
              'We are using <a href="http://panathenaia.halfmoon.jp/alang/grass/grass.ml">the OCaml interpreter</a> written by YT.'],
  'lamb' => ['http://www.golfscript.com/lam/',
             'Universal Lambda is proposed by flagitious. We are using <a href="http://kiritanpo.dyndns.org/clamb.c">the C interpreter written by irori</a>.'],
  'wr' => ['http://bigzaphod.org/whirl/',
           'We are using <a href="http://bigzaphod.org/whirl/whirl.cpp">the C++ interpreter</a>.'],
  's' => [apt['binutils']],
  'out' => [`uname -srvmo`],
  'z8b' => ['Modified fMSX (http://golf.shinh.org/z80golf.tgz)',
            'See <a href="http://sites.google.com/site/codegolfingtips/Home/z80">this site</a> for more detail.'],
  'com' => [apt['dosemu']],
  'class' => [apt['sun-java6-jre']],
  'vi' => [apt['vim']],
  'grb' => ['ruby 1.9.1p243 (2009-07-16 revision 24175) (http://ruby-lang.org/)'],
  'groovy' => [apt['groovy']],
  'clj' => ['Clojure 1.1.0 with clojure-contrib 1.1.0 (http://code.google.com/p/clojure/downloads/list)'],
  'zsh' => [apt['zsh']],
  'fish' => [apt['fish']],
  'bc' => [apt['bc']],
  'wake' => ['http://shinh.skr.jp/wake/',
            'We are using the C++ implementation.'],
  'dc' => [apt['dc']],
  'scala' => [apt['scala']],
  'logo' => [apt['ucblogo']],
  'oct' => [apt['octave3.2']],
  'exu' => ['Euphoria Interpreter 3.1.1 for Linux (http://www.rapideuphoria.com/31/euphor31.tar)'],
  'k' => ['81e95b395144f4b02fe8782ad87c1f218b511c43 (https://github.com/kevinlawler/kona/)'],
  'piet' => ['npiet-1.3a (http://www.bertnase.de/npiet/)'],
  'clci' => [apt['clc-intercal']],
  'mal' => ['Slightly modified reference implementation in C (https://github.com/shinh/ags/blob/master/be/fetcher/malbolge.c)'],
  'icn' => [apt['iconc']],
  'sno' => ['snobol4-1.4.1 (http://www.snobol4.org/)'],
  'rexx' => [apt['regina-rexx']],
  'gp' => [apt['pari-gp']],
  'gplot' => [apt['gnuplot']],
  'blsq' => ['Burlesque e4e7ff873e2f7a9d99ca658a78a5cf3de60fe9b0 in github (https://github.com/FMNSSun/Burlesque)'],
  'rs' => ['Rust 1.8.0 (http://www.rust-lang.org/)'],
  'nut' => ['Squirrel 3.1 beta (http://squirrel-lang.org/)'],
  'chpl' => ['Chapel 1.7.0 (http://chapel.cray.com/)'],
  'pike' => [apt['pike7.6-core']],
  'jq' => [apt['jq']],
  'aheui' => ['f1376d776b9a3940c6ead0b34e54b0dd07e6a2c1 (https://github.com/aheui/caheui)'],
  'mk' => [apt['make']],
  'fsh' => ['3b16018cb47f2f9ad1fa085c155cc5c0dc448b2d (https://gist.github.com/anonymous/6392418)'],
  'crystal' => ['Crystal 0.9.1 [b3b1223] (Fri Oct 30 03:36:50 UTC 2015)'],
#  'hxg' => ['522012d75e340343c5f097e9c2f2aec37a49629e (https://github.com/m-ender/hexagony)'],
#  'lab' => ['f1376d776b9a3940c6ead0b34e54b0dd07e6a2c1 (https://github.com/m-ender/labyrinth)'],
  'jelly' => ['2f7103853033b2f04a419ca737011dc4c4c22196 (https://github.com/shinh/jellylanguage/)'],
  'nbb' => ['1.00 (http://golfscript.com/nibbles/)'],
  'jq16' => ['jq-1.6-145-ga9f97e9-dirty'],
  'vy' => ['Vyxal 2.18.2 (https://github.com/Vyxal/Vyxal)'],
}

LANGS.each do |l, info|
  version = info[0]
  version.gsub!(/https?:\/\/[^)]+/, '<a href="\&">\&</a>')
  version += "<br>#{info[1]}" if info[1]
  puts "#{l} #{version}"
end

