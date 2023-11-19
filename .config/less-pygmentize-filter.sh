#!/usr/bin/env bash
# uses Pygments v2.12.0 for syntax highlighting on applicable file types
# https://github.com/CoeJoder/lessfilter-pygmentize/blob/master/.lessfilter
#

for path in "$@"; do
	# match by known filenames
	filename=$(basename "$path")
	case "$filename" in
	.bash_aliases | .bash_environment | .bash_login | .bash_logout | \
		.bash_profile | .cshdirs | .cshrc | .profile | .tcshrc | .zlogin | .zlogout | \
		.zprofile | bash.bashrc | csh.cshrc | csh.login | csh.logout | ksh.kshrc | zlogin | \
		zlogout | zprofile)
		# shell lexer
		pygmentize -f 256 -O style="$PYGMENTIZE_STYLE" -l sh "$path"
		;;
	.Renviron | .Rhistory | .Rprofile | .SRCINFO | .bashrc | .editorconfig | .exrc | \
		.gvimrc | .htaccess | .kshrc | .vimrc | .zshrc | BUCK | BUILD | BUILD.bazel | \
		CMakeLists.txt | Dockerfile | GNUmakefile | Gemfile | Kconfig* | Makefile | \
		Makefile.* | PKGBUILD | Pipfile | Pipfile.lock | Procfile | Rakefile | SConscript | \
		SConstruct | Singularity | Vagrantfile | WORKSPACE | apache.conf | apache2.conf | \
		autodelegate | autohandler | bashrc | control | dhandler | exrc | external.in* | \
		gvimrc | iddsa | idecdsa | idecdsask | ided25519 | ided25519sk | idrsa | kshrc | \
		lighttpd.conf | makefile | meson.build | mesonoptions.txt | nginx.conf | \
		pacman.conf | poetry.lock | sources.list | squid.conf | standard-modules.in | \
		termcap | termcap.src | terminfo | terminfo.src | todo.txt | vimrc | xorg.conf | \
		zshrc)
		# filename recognized
		pygmentize -f 256 -O style="$PYGMENTIZE_STYLE" "$path"
		;;
	*)
		ext=$([[ "$filename" = *.* ]] && echo ".${filename##*.}" || echo '')
		case "$ext" in
		.1p | .3pm | .6pl | .6pm | .ABAP | .ASM | .BAS | .C | .CBL | .COB | .CPP | .CPY | .F | \
			.F03 | .F90 | .G | .H | .ICON | .P | .PRG | .R | .Rd | .Rout | .S | .SAS | .VBS | \
			.[1-9] | .[gs]sed | .abap | .abnf | .ada | .adb | .adl | .adlf | .adls | .adlx | \
			.ado | .ads | .aes | .agda | .aheui | .ahk | .ahkl | .aj | .als | .ans | .apl | \
			.aplc | .aplf | .apli | .apln | .aplo | .applescript | .arexx | .arw | .as | \
			.asax | .asc | .ascx | .ashx | .asm | .asmx | .aspx | .asy | .at | .au3 | .aug | \
			.automount | .aux | .awk | .axd | .b | .bare | .bas | .bash | .bat | .bb | .bbc | \
			.bc | .be | .befunge | .bf | .bib | .bmx | .bnf | .boa | .boo | .bpl | .bro | .bst | \
			.bug | .bzl | .c | .c++ | .c++-objdump | .c-objdump | .cadl | .camkes | \
			.capnp | .cbl | .cc | .cddl | .cdf | .cdl | .ceylon | .cf | .cfc | .cfg | .cfm | \
			.cfml | .chai | .chpl | .ci | .cirru | .cjs | .cl | .clay | .clj | .cljc | .cljs | \
			.cls | .cmake | .cmd | .cob | .coffee | .cp | .cpl | .cpp | .cpp-objdump | .cps | \
			.cpsa | .cpy | .cr | .crmsh | .croc | .cry | .cs | .csd | .csh | .css | .css.in | \
			.css.j2 | .css.jinja2 | .cssul4 | .cu | .cuh | .cw | .cxx | .cxx-objdump | \
			.cyp | .cypher | .d | .d-objdump | .darcspatch | .dart | .dasm | .dasm16 | \
			.dcl | .decls | .def | .device | .dg | .di | .diff | .dmesg | .do | .docker | \
			.dot | .dpatch | .dpr | .dtd | .dts | .dtsi | .duby | .duel | .dyalog | .dyl | \
			.dylan | .dylan-console | .e | .ebnf | .ebuild | .ec | .ecl | .eclass | .edp | \
			.eex | .eg | .eh | .el | .elm | .elpi | .eml | .eps | .erl | .erl-sh | .es | \
			.escript | .evoque | .ex | .exec | .exheres-0 | .exlib | .exs | .ezt | .f | \
			.f03 | .f90 | .factor | .fan | .fancypack | .feature | .fhtml | .fish | .flo | \
			.flx | .flxh | .fnl | .frag | .frt | .fs | .fsi | .fst | .fsti | .fun | .fut | .fy | \
			.g | .gap | .gcode | .gd | .gdc | .gemspec | .geo | .gi | .go | .golo | .gradle | \
			.graph | .groovy | .gs | .gsp | .gsql | .gst | .gsx | .gv | .h | .h++ | .haml | \
			.handlebars | .hbs | .hdp | .hh | .hlsl | .hlsli | .hpp | .hrl | .hs | .hsail | \
			.htm | .htm.j2 | .htm.jinja2 | .html | .html.j2 | .html.jinja2 | .htmlul4 | \
			.hx | .hxml | .hxsl | .hxx | .hy | .hyb | .i | .i6t | .i7x | .icl | .icn | .icon | \
			.idc | .idl | .idl4 | .idr | .ijs | .ik | .inc | .inf | .ini | .ino | .instances | \
			.intr | .io | .ipf | .isa | .j | .jade | .jag | .java | .jbst | .jcl | .jl | .js | \
			.js.in | .js.j2 | .js.jinja2 | .jsgf | .jslt | .jsm | .json | .jsonld | .jsp | \
			.jsul4 | .juttle | .jy | .k | .kal | .kid | .kif | .kk | .kki | .kmsg | .kn | .ksh | \
			.kt | .kts | .lagda | .lasso | .lasso[89] | .lcry | .lean | .leex | .less | \
			.lgt | .lhs | .lid | .lidr | .liquid | .lisp | .ll | .load | .logtalk | .lpad | \
			.ls | .lsl | .lsp | .lua | .ly | .m | .m2 | .ma | .mac | .mak | .man | .mao | .maql | \
			.markdown | .mask | .max | .mc | .mcfunction | .md | .mhtml | .mi | .mir | .mjs | \
			.mk | .ml | .mli | .mll | .mly | .mm | .mo | .mod | .monkey | .moo | .moon | .mos | \
			.mount | .mq4 | .mq5 | .mqh | .ms | .msc | .mt | .mu | .mxml | .myt | .n | .nb | .nbp | \
			.nc | .ncl | .ng2 | .ni | .nim | .nimrod | .nit | .nix | .nl | .nqp | .ns2 | .nsh | \
			.nsi | .nt | .objdump | .objdump-intel | .odin | .ooc | .opa | .orc | .p | .p6 | \
			.p6l | .p6m | .pan | .pas | .patch | .path | .pc | .pcmk | .peg | .pem | .perl | \
			.php | .php[345] | .phtml | .pidl | .pig | .pike | .pl | .pl6 | .plot | .plt | \
			.pm | .pm6 | .pmod | .po | .pony | .pot | .pov | .pp | .praat | .prg | .pro | .proc | \
			.prolog | .promql | .properties | .proto | .ps | .ps1 | .psc | .psi | .psl | \
			.psm1 | .ptls | .pug | .pwn | .pxd | .pxi | .py | .py2tb | .py3tb | .pypylog | \
			.pytb | .pyul4 | .pyw | .pyx | .q | .qbs | .qml | .qvs | .qvto | .qvw | .r | .r3 | \
			.rake | .raku | .rakudoc | .rakumod | .rakutest | .rb | .rbw | .rbx | .re | \
			.reb | .red | .reds | .reg | .rei | .resource | .rest | .rex | .rexx | .rhtml | \
			.ride | .rita | .rkt | .rktd | .rktl | .rl | .rnc | .robot | .rpf | .rq | .rql | \
			.rs | .rs.in | .rsl | .rss | .rst | .rts | .run | .rvt | .rx | .s | .sage | .sarl | \
			.sas | .sass | .savi | .sbl | .sc | .scala | .scaml | .scd | .scdoc | .sce | .sci | \
			.scm | .sco | .scope | .scss | .sed | .service | .sgf | .sh | .sh-session | \
			.shell-session | .shen | .shex | .sieve | .sig | .sil | .siv | .sl | .sla | \
			.slice | .slim | .sls | .smali | .smithy | .sml | .smv | .snbt | .snobol | \
			.socket | .sol | .sp | .sparql | .spec | .spice | .spt | .sql | .sql.j2 | \
			.sql.jinja2 | .sqlite3-console | .ss | .ssp | .st | .stan | .sv | .svh | \
			.swap | .swg | .swift | .t | .tac | .tal | .tap | .target | .tasm | .tcl | .tcsh | \
			.tea | .teal | .tex | .tf | .thrift | .thy | .ti | .tid | .timer | .tmpl | .tnt | \
			.toc | .todotxt | .toml | .tpl | .tpp | .treetop | .ts | .tst | .tt | .ttl | \
			.twig | .txt | .typoscript | .u | .u1 | .u2 | .udo | .ul4 | .usd | .usda | .v | \
			.vala | .vapi | .vark | .vb | .vbs | .vcl | .vert | .vhd | .vhdl | .vim | .vm | \
			.vpr | .wast | .wat | .wdiff | .webidl | .weechatlog | .whiley | .wlua | \
			.wsdl | .wsf | .x | .x10 | .x[bp]m | .xhtml | .xhtml.j2 | .xhtml.jinja2 | .xi | \
			.xm | .xmi | .xml | .xml.j2 | .xml.jinja2 | .xmlul4 | .xpl | .xq | .xql | .xqm | \
			.xquery | .xqy | .xsd | .xsl | .xslt | .xtend | .xtm | .xul.in | .yaml | \
			.yaml.j2 | .yaml.jinja2 | .yang | .yml | .yml.j2 | .yml.jinja2 | .zeek | \
			.zep | .zig | .zsh | Config.in*)
			# extension recognized
			pygmentize -f 256 -O style="$PYGMENTIZE_STYLE" "$path"
			;;
		*)
			# unrecognized filename/extension
			# attempt to parse the lexer from the shebang if it exists
			lexer=$(head -n 1 "$path" | grep "^#\!" | awk -F" " \
				'match($1, /\/(\w*)$/, a) {if (a[1]!="env") {print a[1]} else {print $2}}')
			case "$lexer" in
			node | nodejs)
				# workaround for lack of Node.js lexer alias
				pygmentize -f 256 -O style="$PYGMENTIZE_STYLE" \
					-l js "$path"
				;;
			"")
				# fall-back to plain text
				exit 1
				;;
			*)
				# use lexer alias parsed from the shebang
				pygmentize -f 256 -O style="$PYGMENTIZE_STYLE" \
					-l "$lexer" "$path"
				;;
			esac
			;;
		esac
		;;
	esac
done
exit 0
