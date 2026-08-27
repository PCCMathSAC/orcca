#############################################################################
# This macro library supports WeBWorK problems from the PreTeXt project named
# Open Resources for Community College Algebra
#############################################################################


# omit e since it can be confused with Euler's constant
# omit o since it can be confused with zero
# omit E since it can be confused with indicating scientific notation
# omit O since it can be confused with zero
# omit U since it can be confused with union operator
@ORCCA_variables = grep {!/eoEOU/} ('a' .. 'z', 'A' .. 'Z');

# canonical units, and things students might enter instead
%unitAlternatives = (
  ft => ['foot', 'feet'],
  in => ['inch', 'inches'],
  yd => ['yard', 'yards'],
  mi => ['mile', 'miles'],
  m => ['meter', 'meters'],
  mm => ['millimeter', 'millimeters'],
  cm => ['centimeter', 'centimeters'],
  dm => ['decimeter', 'decimeters'],
  dam => ['dekameter', 'dekameters'],
  hm => ['hectometer', 'hectometers'],
  km => ['kilometer', 'kilometers'],
  acre => ['acres'],
  'ft^2' => ['foot^2', 'feet^2'],
  'mi^2' => ['mile^2', 'miles^2'],
  ha => ['hectare', 'hectares'],
  'm^2' => ['meter^2', 'meters^2'],
  'km^2' => ['kilometer^2', 'kilometers^2'],
  tbsp => ['tablespoon', 'tablespoons'],
  tsp => ['teaspoon', 'teaspoons'],
  c => ['cup', 'cups'],
  pt => ['pint', 'pints'],
  qt => ['quart', 'quarts'],
  gal => ['gallon', 'gallons'],
  'in^3' => ['inch^3', 'inches^3'],
  cc => ['cm^3', 'centimeter^3', 'centimeters^3'],
  'cm^3' => ['cc', 'centimeter^3', 'centimeters^3'],
  mL => ['ml', 'milliliter', 'milliliters'],
  L => ['l', 'liter', 'liters'],
  lb => ['lbs', 'pound', 'pounds'],
  oz => ['ounce', 'ounces'],
  T => ['ton', 'tons'],
  g => ['gram', 'grams'],
  mg => ['milligram', 'milligrams'],
  kg => ['kilogram', 'kilograms'],
  t => ['tonne', 'tonnes'],
  wk => ['w', 'week', 'weeks'],
  d => ['day', 'days'],
  h => ['hr', 'hrs', 'hour', 'hours'],
  min => ['minute', 'minutes'],
  s => ['sec', 'second', 'seconds'],
  ms => ['millisecond', 'milliseconds'],
  ns => ['nanosecond', 'nanoseconds'],
  b => ['bit', 'bits'],
  B => ['byte', 'bytes'],
  kb => ['kilobit', 'kilobits'],
  kB => ['kilobyte', 'kilobytes'],
  Mb => ['megabit', 'megabits'],
  MB => ['megabyte', 'megabytes'],
  GB => ['giabyte', 'gigabytes'],
  TB => ['terabyte', 'terabytes'],
);

%unitWords = (
  ft => 'feet',
  in => 'inches',
  yd => 'yards',
  mi => 'miles',
  m => 'meters',
  mm => 'millimeters',
  cm => 'centimeters',
  dm => 'decimeters',
  dam => 'dekameters',
  hm => 'hectometers',
  km => 'kilometers',
  acre => 'acres',
  'ft^2' => 'square feet',
  'mi^2' => 'square miles',
  'ha' => 'hectares',
  'km^2' => 'square kilometers',
  'm^2' => 'square meters',
  tbsp => 'tablespoons',
  tsp => 'teaspoons',
  c => 'cups',
  pt => 'pints',
  qt => 'quarts',
  gal => 'gallons',
  'in^3' => 'cubic inches',
  cc => 'cubic centimeters',
  'cm^3' => 'cubic centimeters',
  mL => 'milliliters',
  L => 'liters',
  lb => 'pounds',
  oz => 'ounces',
  T => 'tons',
  g => 'grams',
  mg => 'milligrams',
  kg => 'kilograms',
  t => 'metric tons',
  wk => 'weeks',
  d => 'days',
  h => 'hours',
  min => 'minutes',
  s => 'seconds',
  ms => 'milliseconds',
  ns => 'nanoseconds',
  b => 'bits',
  B => 'bytes',
  kb => 'kilobits',
  kB => 'kilobytes',
  Mb => 'megabits',
  MB => 'megabytes',
  GB => 'gigabytes',
  TB => 'terabytes',
);

#singular
%unitWord = (
  ft => 'foot',
  in => 'inch',
  yd => 'yard',
  mi => 'mile',
  m => 'meter',
  mm => 'millimeter',
  cm => 'centimeter',
  dm => 'decimeter',
  dam => 'dekameter',
  hm => 'hectometer',
  km => 'kilometer',
  acre => 'acre',
  'ft^2' => 'square foott',
  'mi^2' => 'square mile',
  'ha' => 'hectare',
  'km^2' => 'square kilometer',
  'm^2' => 'square meter',
  tbsp => 'tablespoon',
  tsp => 'teaspoon',
  c => 'cup',
  pt => 'pint',
  qt => 'quart',
  gal => 'gallon',
  'in^3' => 'cubic inch',
  cc => 'cubic centimeter',
  'cm^3' => 'cubic centimeter',
  mL => 'milliliter',
  L => 'liter',
  lb => 'pound',
  oz => 'ounce',
  T => 'ton',
  g => 'gram',
  mg => 'milligram',
  kg => 'kilogram',
  t => 'metric ton',
  wk => 'week',
  d => 'day',
  h => 'hour',
  min => 'minute',
  s => 'second',
  ms => 'millisecond',
  ns => 'nanosecond',
  b => 'bit',
  B => 'byte',
  kb => 'kilobit',
  kB => 'kilobyte',
  Mb => 'megabit',
  MB => 'megabyte',
  GB => 'gigabyte',
  TB => 'terabyte',
);

@ORCCAunits = (
  {name => 'ft', conversion => {factor => 12*2.54/100, m => 1}},
  {name => 'in', conversion => {factor => 2.54/100, m => 1}},
  {name => 'yd', conversion => {factor => 3*12*2.54/100, m => 1}},
  {name => 'mi', conversion => {factor => 5280*12*2.54/100, m => 1}},
  {name => 'm', conversion => {factor => 1, m => 1}},
  {name => 'mm', conversion => {factor => 1E-3, m => 1}},
  {name => 'cm', conversion => {factor => 1E-2, m => 1}},
  {name => 'dm', conversion => {factor => 1E-1, m => 1}},
  {name => 'dam', conversion => {factor => 1E1, m => 1}},
  {name => 'hm', conversion => {factor => 1E2, m => 1}},
  {name => 'km', conversion => {factor => 1E3, m => 1}},
  {name => 'acre', conversion => {factor => 4046.86, m => 2}},
  {name => 'ft^2', conversion => {factor => 0.092903, m => 2}},
  {name => 'mi^2', conversion => {factor => 2589980, m => 2}},
  {name => 'ha', conversion => {factor => 1E4, m => 2}},
  {name => 'km^2', conversion => {factor => 1E6, m => 2}},
  {name => 'tbsp', conversion => {factor => 1.4787E-5, m => 3}},
  {name => 'tsp', conversion => {factor => 4.9289E-6, m => 3}},
  {name => 'c', conversion => {factor => 0.000473176/2, m => 3}},
  {name => 'pt', conversion => {factor => 0.000473176, m => 3}},
  {name => 'qt', conversion => {factor => 0.000946353, m => 3}},
  {name => 'gal', conversion => {factor => 0.00378541, m => 3}},
  {name => 'in^3', conversion => {factor => 1.63871E-5, m => 3}},
  {name => 'cc', conversion => {factor => 1E-6, m => 3}},
  {name => 'cm^3', conversion => {factor => 1E-6, m => 3}},
  {name => 'mL', conversion => {factor => 1E-6, m => 3}},
  {name => 'L', conversion => {factor => 0.001, m => 3}},
  {name => 'lb', conversion => {factor => 4.44822, kg => 1, m => 1, s => -2}},
  {name => 'oz', conversion => {factor => 4.44822/16, kg => 1, m => 1, s => -2}},
  {name => 'T', conversion => {factor => 2000*4.44822, kg => 1, m => 1, s => -2}},
  {name => 'g', conversion => {factor => 1E-3, kg => 1}},
  {name => 'mg', conversion => {factor => 1E-6, kg => 1}},
  {name => 'kg', conversion => {factor => 1, kg => 1}},
  {name => 't', conversion => {factor => 1E3, kg => 1}},
  {name => 'wk', conversion => {factor => 7*24*60*60, s => 1}},
  {name => 'd', conversion => {factor => 24*60*60, s => 1}},
  {name => 'h', conversion => {factor => 60*60, s => 1}},
  {name => 'min', conversion => {factor => 60, s => 1}},
  {name => 's', conversion => {factor => 1, s => 1}},
  {name => 'ms', conversion => {factor => 1E-3, s => 1}},
  {name => 'ns', conversion => {factor => 1E-9, s => 1}},
  {name => 'b'},
  {name => 'B', conversion => {factor => 8, b => 1}},
  {name => 'kb', conversion => {factor => 2**10, b => 1}},
  {name => 'kB', conversion => {factor => 8*2**10, b => 1}},
  {name => 'Mb', conversion => {factor => 2**20, b => 1}},
  {name => 'MB', conversion => {factor => 8*2**20, b => 1}},
  {name => 'GB', conversion => {factor => 8*2**30, b => 1}},
  {name => 'TB', conversion => {factor => 8*2**40, b => 1}},
);

my @alternateUnits;
for my $unit (@ORCCAunits) {
  my $name = $unit->{name};
  my $conversion = (defined ($unit->{conversion})) ? $unit->{conversion} : 0;
  for my $alternative (@{$unitAlternatives{$name}}) {
    my $newunit = ($conversion) ? {name => $alternative, conversion => $conversion} : {name => $alternative, conversion => {factor => 1, $unit => 1}};
    push (@alternateUnits, $newunit);
  };
};
push (@ORCCAunits, @alternateUnits);
$ORCCAunits = \@ORCCAunits;

# These are conversions directly given by the appendix in ORCCA
%ORCCAconversions = (
  ft => {in => 12, yd => 1/3, mi => 1/5280, m => 1/3.281},
  in => {ft => 1/12, yd => 1/36, cm => 2.54},
  yd => {ft => 3, in => 36, m => 1/1.094},
  mi => {ft => 5280, km => 1.609},
  m => {mm => 1000, cm => 100, dm => 10, dam => 1/10, hm => 1/100, km => 1/1000, ft => 3.281, yd => 1.094},
  mm => {m => 1/1000},
  cm => {m => 1/100, in => 1/2.54},
  dm => {m => 1/10},
  dam => {m => 10},
  hm => {m => 100},
  km => {m => 1000, mi => 1/1.609},
  acre => {'ft^2' => 43560, ha => 1/2.471, 'mi^2' => 1/640},
  'ft^2' => {acre => 1/43560},
  'mi^2' => {acre => 640},
  ha => {'m^2' => 10000, acre => 2.471, 'km^2' => 1/100},
  'm^2' => {ha => 1/10000},
  'km^2' => {ha => 100},
  tbsp => {tsp => 3},
  tsp => {tbsp => 1/3},
  pt => {c => 2, qt => 1/2},
  c => {pt => 1/2},
  qt => {pt => 2, gal => 1/4, L => 1/1.057},
  gal => {qt => 4, 'in^3' => 231, L => 3.785},
  'in^3' => {gal => 1/231, mL => 16.39},
  'mL' => {cc => 1, 'cm^3' => 1, L => 1/1000, 'in^3' => 1/16.39},
  cc => {mL => 1, L => 1/1000},
  'cm^3' => {mL => 1, L => 1/1000},
  L => {mL => 1000, 'cm^3' => 1000, cc => 1000, qt => 1.057, gal => 1/3.785},
  lb => {oz => 16, T => 1/2000},
  oz => {lb => 1/16},
  T => {lb => 2000},
  g => {mg => 1000, kg => 1/1000},
  mg => {g => 1/1000},
  kg => {g => 1000, t => 1/1000},
  t => {kg => 1000},
  wk => {d => 7},
  d => {wk => 1/7, h => 24},
  h => {d => 1/24, min => 60},
  min => {h => 1/60, s => 60},
  s => {min => 1/60, ms => 1000, ns => 10**9},
  ms => {s => 1/1000},
  ns => {s => 1/10**9},
  b => {B => 1/8, kb => 1/1024},
  B => {b => 8, kB => 1/1024},
  kb => {b => 1024, Mb => 1/1024},
  kB => {B => 1024, MB => 1/1024},
  Mb => {kb => 1024},
  MB => {kB => 1024, GB => 1/1024},
  GB => {MB => 1024, TB => 1/1024},
  TB => {GB => 1024},
);

TEXT(
    MODES(
        HTML => '<div style="display:none;">' . general_math_ev3(<<'EOF') . '</div>',
\require{cancel}
\newcommand{\abs}[1]{\left\lvert#1\right\rvert}
\newcommand{\point}[2]{\left(#1,#2\right)}
\newcommand{\highlight}[1]{\mathchoice{\colorbox{lightsapphire}{$\displaystyle #1$}}{\colorbox{lightsapphire}{$\textstyle #1$}}{\colorbox{lightsapphire}{$\scriptstyle #1$}}{\colorbox{lightsapphire}{$\scriptscriptstyle #1$}}}
\newcommand{\firsthighlight}[1]{\mathchoice{\colorbox{lightsapphire}{$\displaystyle #1$}}{\colorbox{lightsapphire}{$\textstyle #1$}}{\colorbox{lightsapphire}{$\scriptstyle #1$}}{\colorbox{lightsapphire}{$\scriptscriptstyle #1$}}}
\newcommand{\secondhighlight}[1]{\mathchoice{\colorbox{lightemerald}{$\displaystyle #1$}}{\colorbox{lightemerald}{$\textstyle #1$}}{\colorbox{lightemerald}{$\scriptstyle #1$}}{\colorbox{lightemerald}{$\scriptscriptstyle #1$}}}
\newcommand{\unhighlight}[1]{{\color{black}{{#1}}}}
\newcommand{\lowlight}[1]{{\color{lightgray}{#1}}}
\newcommand{\attention}[1]{\mathord{\overset{\downarrow}{#1}}}
\newcommand{\nextoperation}[1]{\mathord{\boxed{#1}}}
\newcommand{\substitute}[1]{{\color{blue}{{#1}}}}
\newcommand{\pinover}[2]{\overset{\overset{\mathrm{\ #2\ }}{|}}{\strut #1 \strut}}
\newcommand{\addright}[1]{{\highlight{{{}+#1}}}}
\newcommand{\addleft}[1]{{\highlight{{#1+{}}}}}
\newcommand{\subtractright}[1]{{\highlight{{{}-#1}}}}
\newcommand{\multiplyright}[2][\cdot]{{\highlight{{{}#1#2}}}}
\newcommand{\multiplyleft}[2][\cdot]{{\highlight{{#2#1{}}}}}
\newcommand{\divideunder}[2]{\frac{#1}{{\highlight{{#2}}}}}
\newcommand{\divideright}[1]{{\highlight{{{}\div#1}}}}
\newcommand{\negate}[1]{{\highlight{{-}}}\left(#1\right)}
\newcommand{\cancelhighlight}[1]{{\color{sapphire}{{\cancel{#1}}}}}
\newcommand{\secondcancelhighlight}[1]{{\color{emerald}{{\bcancel{#1}}}}}
\newcommand{\thirdcancelhighlight}[1]{\definecolor{amethyst}{RGB}{112,72,91}{\color{amethyst}{{\xcancel{#1}}}}}
\newcommand{\confirm}[1]{\stackrel{\checkmark}{#1}}
\newcommand{\reject}[1]{\stackrel{\text{no}}{#1}}
\newcommand{\wonder}[1]{\stackrel{\text{?}}{#1}}
\newcommand{\apple}{\text{🍎}}
\newcommand{\banana}{\text{🍌}}
\newcommand{\pear}{\text{🍐}}
\newcommand{\cat}{\text{🐱}}
\newcommand{\dog}{\text{🐶}}
\newcommand{\amp}{&}
EOF
        TeX => '\ifdefined\ptxmacros\else ' . <<'EOF'
\require{cancel}
\newcommand{\abs}[1]{\left\lvert#1\right\rvert}
\newcommand{\point}[2]{\left(#1,#2\right)}
\newcommand{\highlight}[1]{\mathchoice{\colorbox{lightsapphire}{$\displaystyle #1$}}{\colorbox{lightsapphire}{$\textstyle #1$}}{\colorbox{lightsapphire}{$\scriptstyle #1$}}{\colorbox{lightsapphire}{$\scriptscriptstyle #1$}}}
\newcommand{\firsthighlight}[1]{\mathchoice{\colorbox{lightsapphire}{$\displaystyle #1$}}{\colorbox{lightsapphire}{$\textstyle #1$}}{\colorbox{lightsapphire}{$\scriptstyle #1$}}{\colorbox{lightsapphire}{$\scriptscriptstyle #1$}}}
\newcommand{\secondhighlight}[1]{\mathchoice{\colorbox{lightemerald}{$\displaystyle #1$}}{\colorbox{lightemerald}{$\textstyle #1$}}{\colorbox{lightemerald}{$\scriptstyle #1$}}{\colorbox{lightemerald}{$\scriptscriptstyle #1$}}}
\newcommand{\unhighlight}[1]{{\color{black}{{#1}}}}
\newcommand{\lowlight}[1]{{\color{lightgray}{#1}}}
\newcommand{\attention}[1]{\mathord{\overset{\downarrow}{#1}}}
\newcommand{\nextoperation}[1]{\mathord{\boxed{#1}}}
\newcommand{\substitute}[1]{{\color{blue}{{#1}}}}
\newcommand{\pinover}[2]{\overset{\overset{\mathrm{\ #2\ }}{|}}{\strut #1 \strut}}
\newcommand{\addright}[1]{{\highlight{{{}+#1}}}}
\newcommand{\addleft}[1]{{\highlight{{#1+{}}}}}
\newcommand{\subtractright}[1]{{\highlight{{{}-#1}}}}
\newcommand{\multiplyright}[2][\cdot]{{\highlight{{{}#1#2}}}}
\newcommand{\multiplyleft}[2][\cdot]{{\highlight{{#2#1{}}}}}
\newcommand{\divideunder}[2]{\frac{#1}{{\highlight{{#2}}}}}
\newcommand{\divideright}[1]{{\highlight{{{}\div#1}}}}
\newcommand{\negate}[1]{{\highlight{{-}}}\left(#1\right)}
\newcommand{\cancelhighlight}[1]{{\color{sapphire}{{\cancel{#1}}}}}
\newcommand{\secondcancelhighlight}[1]{{\color{emerald}{{\bcancel{#1}}}}}
\newcommand{\thirdcancelhighlight}[1]{\definecolor{amethyst}{RGB}{112,72,91}{\color{amethyst}{{\xcancel{#1}}}}}
\newcommand{\confirm}[1]{\stackrel{\checkmark}{#1}}
\newcommand{\reject}[1]{\stackrel{\text{no}}{#1}}
\newcommand{\wonder}[1]{\stackrel{\text{?}}{#1}}
\newcommand{\apple}{\text{🍎}}
\newcommand{\banana}{\text{🍌}}
\newcommand{\pear}{\text{🍐}}
\newcommand{\cat}{\text{🐱}}
\newcommand{\dog}{\text{🐶}}
\newcommand{\amp}{&}
\def\ptxmacros{}
EOF
. '\fi',
        PTX => ''
    )
);

# Return a string containing the latex-image-preamble contents.
# To be used by LaTeXImage objects as in:
# $image->addToPreamble(latexImagePreamble())

sub latexImagePreamble {
return <<'END_LATEX_IMAGE_PREAMBLE'
\newlength{\orccaprintwidth}
\setlength{\orccaprintwidth}{350pt}
\usepackage{pgfplots}
\pgfplotsset{compat=1.18}
\usepackage{pifont}                                         %needed for symbols, s.a. airplane symbol
\usetikzlibrary{positioning,fit,backgrounds}                %needed for nested diagrams
\usetikzlibrary{calc,trees,positioning,arrows,fit,shapes}   %needed for set diagrams
\usetikzlibrary{decorations.text}                           %needed for text following a curve
\usetikzlibrary{arrows,arrows.meta}                         %needed for open/closed intervals
\usetikzlibrary{positioning,3d,shapes.geometric}            %needed for 3d number sets tower
\usepackage{tikz-3dplot}
\usepackage{tkz-euclide}                                    %needed for triangle diagrams
\usepgfplotslibrary{fillbetween}                            %shade regions of a plot
\usetikzlibrary{shadows}                                    %function diagrams
\usetikzlibrary{positioning}                                %function diagrams
\usetikzlibrary{shapes}                                     %function diagrams
%%% global colors from https://www.pcc.edu/web-services/style-guide/basics/color/ %%%
\definecolor{ruby}{HTML}{9e0c0f}
\definecolor{turquoise}{HTML}{008099}
\definecolor{emerald}{HTML}{1c8464}
\definecolor{lightemerald}{HTML}{12A983} %(lightened to contrast ratio just above 7 with black)
\definecolor{sapphire}{HTML}{3b5a7d}
\definecolor{lightsapphire}{HTML}{7898bf} %(lightened to contrast ratio just above 7 with black)
\definecolor{amber}{HTML}{c7502a}
\definecolor{amethyst}{HTML}{70485b}
\colorlet{firstcolor}{ruby}
\colorlet{secondcolor}{turquoise}
\colorlet{thirdcolor}{emerald}
\colorlet{fourthcolor}{amber}
\colorlet{fifthcolor}{amethyst}
\colorlet{sixthcolor}{sapphire}
\colorlet{highlightcolor}{green!50!black}
\colorlet{graphbackground}{yellow!30}
\colorlet{wood}{brown!60!white}
%%% curve, dot, and graph custom styles %%%
\pgfplotsset{firstcurve/.style      = {color=firstcolor,  mark=none, line width=1pt, {Kite}-{Kite}, solid}}
\pgfplotsset{secondcurve/.style     = {color=secondcolor, mark=none, line width=1pt, {Kite}-{Kite}, solid}}
\pgfplotsset{thirdcurve/.style      = {color=thirdcolor,  mark=none, line width=1pt, {Kite}-{Kite}, solid}}
\pgfplotsset{fourthcurve/.style     = {color=fourthcolor, mark=none, line width=1pt, {Kite}-{Kite}, solid}}
\pgfplotsset{fifthcurve/.style      = {color=fifthcolor,  mark=none, line width=1pt, {Kite}-{Kite}, solid}}
\pgfplotsset{highlightcurve/.style  = {color=highlightcolor,  mark=none, line width=5pt, -, opacity=0.3}}   % thick, opaque curve for highlighting
\pgfplotsset{asymptote/.style       = {color=gray, mark=none, line width=1pt, <->, dashed}}
\pgfplotsset{symmetryaxis/.style    = {color=gray, mark=none, line width=1pt, <->, dashed}}
\pgfplotsset{guideline/.style       = {color=gray, mark=none, line width=1pt, -}}
\tikzset{guideline/.style           = {color=gray, mark=none, line width=1pt, -}}
\pgfplotsset{altitude/.style        = {dashed, color=gray, thick, mark=none, -}}
\tikzset{altitude/.style            = {dashed, color=gray, thick, mark=none, -}}
\pgfplotsset{radius/.style          = {dashed, thick, mark=none, -}}
\tikzset{radius/.style              = {dashed, thick, mark=none, -}}
\pgfplotsset{rightangle/.style      = {color=gray, mark=none, -}}
\tikzset{rightangle/.style          = {color=gray, mark=none, -}}
\pgfplotsset{closedboundary/.style  = {color=black, mark=none, line width=1pt, {Kite}-{Kite},solid}}
\tikzset{closedboundary/.style      = {color=black, mark=none, line width=1pt, {Kite}-{Kite},solid}}
\pgfplotsset{openboundary/.style    = {color=black, mark=none, line width=1pt, {Kite}-{Kite},dashed}}
\tikzset{openboundary/.style        = {color=black, mark=none, line width=1pt, {Kite}-{Kite},dashed}}
\tikzset{verticallinetest/.style    = {color=gray, mark=none, line width=1pt, <->,dashed}}
\pgfplotsset{soliddot/.style        = {color=firstcolor,  mark=*, only marks}}
\pgfplotsset{hollowdot/.style       = {color=firstcolor,  mark=*, only marks, fill=graphbackground}}
\pgfplotsset{blankgraph/.style      = {xmin=-10, xmax=10,
                                        ymin=-10, ymax=10,
                                        axis line style={-, draw opacity=0 },
                                        axis lines=box,
                                        major tick length=0mm,
                                        xtick={-10,-9,...,10},
                                        ytick={-10,-9,...,10},
                                        grid=major,
                                        grid style={solid,gray!40},
                                        xticklabels={,,},
                                        yticklabels={,,},
                                        minor xtick=,
                                        minor ytick=,
                                        xlabel={},ylabel={},
                                        width=0.75\textwidth,
                                      }
            }
\pgfplotsset{numberline/.style      = {xmin=-10,xmax=10,
                                        minor xtick={-11,-10,...,11},
                                        xtick={-10,-5,...,10},
                                        every tick/.append style={thick},
                                        axis y line=none,
                                        axis lines=middle,
                                        enlarge x limits,
                                        grid=none,
                                        clip=false,
                                        y=1cm,
                                        ymin = -1,ymax = 1,
                                        axis background/.style={},
                                        width=\orccaprintwidth,
                                        after end axis/.code={
                                          \path (axis cs:0,0)
                                          node [anchor=north,yshift=-0.075cm] {\footnotesize 0};
                                        },
                                        every axis x label/.style={at={(current axis.right of origin)},anchor=north},
                                      }
            }
\pgfplotsset{openinterval/.style={color=firstcolor,mark=none,ultra thick,{Parenthesis}-{Parenthesis}}}
\pgfplotsset{openclosedinterval/.style={color=firstcolor,mark=none,ultra thick,{Parenthesis}-{Bracket}}}
\pgfplotsset{closedinterval/.style={color=firstcolor,mark=none,ultra thick,{Bracket}-{Bracket}}}
\pgfplotsset{closedopeninterval/.style={color=firstcolor,mark=none,ultra thick,{Bracket}-{Parenthesis}}}
\pgfplotsset{infiniteopeninterval/.style={color=firstcolor,mark=none,ultra thick,{Kite}-{Parenthesis}}}
\pgfplotsset{openinfiniteinterval/.style={color=firstcolor,mark=none,ultra thick,{Parenthesis}-{Kite}}}
\pgfplotsset{infiniteclosedinterval/.style={color=firstcolor,mark=none,ultra thick,{Kite}-{Bracket}}}
\pgfplotsset{closedinfiniteinterval/.style={color=firstcolor,mark=none,ultra thick,{Bracket}-{Kite}}}
\pgfplotsset{infiniteinterval/.style={color=firstcolor,mark=none,ultra thick,{Kite}-{Kite}}}
\pgfplotsset{interval/.style= {ultra thick, -}}
%%% cycle list of plot styles for graphs with multiple plots %%%
\pgfplotscreateplotcyclelist{pccstylelist}{%
  firstcurve\\%
  secondcurve\\%
  thirdcurve\\%
  fourthcurve\\%
  fifthcurve\\%
}
%%% default plot settings %%%
\pgfplotsset{every axis/.append style={
  axis x line=middle,    % put the x axis in the middle
  axis y line=middle,    % put the y axis in the middle
  axis line style={<->}, % arrows on the axis
  scaled ticks=false,
  tick label style={/pgf/number format/fixed},
  xlabel={\(x\)},          % default put x on x-axis
  ylabel={\(y\)},          % default put y on y-axis
  xmin = -7,xmax = 7,    % most graphs have this window
  ymin = -7,ymax = 7,    % most graphs have this window
  domain = -7:7,
  xtick = {-6,-4,...,6}, % label these ticks
  ytick = {-6,-4,...,6}, % label these ticks
  yticklabel style={inner sep=0.333ex},
  minor xtick = {-7,-6,...,7}, % include these ticks, some without label
  minor ytick = {-7,-6,...,7}, % include these ticks, some without label
  scale only axis,       % don't consider axis and tick labels for width and height calculation
  cycle list name=pccstylelist,
  tick label style={font=\footnotesize},
  legend cell align=left,
  grid = both,
  grid style = {solid,gray!40},
  axis background/.style={fill=graphbackground},
}}
\pgfplotsset{framed/.style={axis background/.style ={draw=gray}}}
%\pgfplotsset{framed/.style={axis background/.style ={draw=gray,fill=graphbackground,rounded corners=3ex}}}
%%% other tikz (not pgfplots) settings %%%
%\tikzset{axisnode/.style={font=\scriptsize,text=black}}
\tikzset{>=stealth}
%%% for nested diagram in types of numbers section %%%
\newcommand\drawnestedsets[4]{
  \def\position{#1}             % initial position
  \def\nbsets{#2}               % number of sets
  \def\listofnestedsets{#3}     % list of sets
  \def\reversedlistofcolors{#4} % reversed list of colors
  % position and draw labels of sets
  \coordinate (circle-0) at (#1);
  \coordinate (set-0) at (#1);
  \foreach \set [count=\c] in \listofnestedsets {
    \pgfmathtruncatemacro{\cminusone}{\c - 1}
    % label of current set (below previous nested set)
    \node[below=3pt of circle-\cminusone,inner sep=0]
    (set-\c) {\set};
    % current set (fit current label and previous set)
    \node[circle,inner sep=0,fit=(circle-\cminusone)(set-\c)]
    (circle-\c) {};
  }
  % draw and fill sets in reverse order
  \begin{scope}[on background layer]
    \foreach \col[count=\c] in \reversedlistofcolors {
      \pgfmathtruncatemacro{\invc}{\nbsets-\c}
      \pgfmathtruncatemacro{\invcplusone}{\invc+1}
      \node[circle,draw,fill=\col,inner sep=0,
      fit=(circle-\invc)(set-\invcplusone)] {};
    }
  \end{scope}
  }

END_LATEX_IMAGE_PREAMBLE
}

1;
