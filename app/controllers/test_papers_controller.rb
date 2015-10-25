class TestPapersController < ApplicationController

  require 'ParsePapers'
  require 'nokogiri'
  before_action :set_test_paper, only: [:show, :edit, :update, :destroy]

  def index
    @test_papers = TestPaper.all
  end

  def upload
    @testpaprs = TestPaper.all
  end
  def parse
    question_meta_data = Nokogiri::Slop <<-EOXML
<root>
<q index1="|B.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q13W.C1.01" qid="Q13W.C1.01" des="Midpoint/grad/perp/int lines" index7="12.2a" marks="11 marks" time="13" ttext="Straight lines"></q>
<q index1="|D.A|D.A.A$|D.A.J.1$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q13W.C1.02" qid="Q13W.C1.02" des="Rate of change/incr/decr" index7="12.3a | 12.3b | 12.3c" marks="8 marks" time="10" ttext="Differentiation | Polynomials | Maxima and minima"></q>
<q index1="|A.I$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q13W.C1.03" qid="Q13W.C1.03" des="Simplifying/rationalising denom" index7="12.1a" marks="8 marks" time="10" ttext="Surds/indices"></q>
<q index1="|A.C$|A.H$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q13W.C1.04" qid="Q13W.C1.04" des="Associated graph/vertex" index7="12.1b | 12.1f" marks="12 marks" time="14" ttext="Completing the square | Transformation of graphs"></q>
<q index1="|A.A$|A.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q13W.C1.05" qid="Q13W.C1.05" des="Factorisation of cubic/sketch" index7="12.1e | 12.1f" marks="10 marks" time="12" ttext="Factor theorem | Remainder theorem"></q>
<q index1="|B.B$|D.B.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q13W.C1.06" qid="Q13W.C1.06" des="Quartic integ/tgt eqn/curve eqn" index7="12.2c | 12.4a" marks="8 marks" time="10" ttext="Straight lines | Integration of polynomials"></q>
<q index1="|B.A$|B.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q13W.C1.07" qid="Q13W.C1.07" des="Radius/lengths of line and tgt" index7="12.2a | 12.2b" marks="10 marks" time="12" ttext="Circle | Straight lines"></q>
<q index1="|A.D$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q13W.C1.08" qid="Q13W.C1.08" des="Int curve/line;discrim/ineq soln" index7="12.1b | 12.1d | 12.2d" marks="8 marks" time="10" ttext="Inequalities"></q>
<q index1="|J.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q13W.C2.01" qid="Q13W.C2.01" des="Standard perimeter/area of sector" index7="13.3b" marks="5 marks" time="6" ttext="Arc length/area of sectors/segments"></q>
<q index1="|D.B.B$|D.B.H$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q13W.C2.02" qid="Q13W.C2.02" des="Trap rule and definite integration" index7="13.6a | 13.6b" marks="9 marks" time="11" ttext="Integration of non-integer powers of x | Trapezium rule"></q>
<q index1="|J.D$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q13W.C2.03" qid="Q13W.C2.03" des="Area formula and cosine rule" index7="13.3a" marks="6 marks" time="7" ttext="Sine and cosine rules/area of triangle"></q>
<q index1="|F.E$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q13W.C2.04" qid="Q13W.C2.04" des="Std logarithmic manip" index7="13.4a" marks="3 marks" time="4" ttext="Logarithmic function"></q>
<q index1="|B.B$|D.A.B$|D.A.J.1$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q13W.C2.05" qid="Q13W.C2.05" des="Eqns/int of normal/tgt" index7="13.5" marks="12 marks" time="14" ttext="Straight lines | Non-integer powers of x | Maxima and minima"></q>
<q index1="|H.A$|H.B$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q13W.C2.06" qid="Q13W.C2.06" des="Typical GP and AP problems" index7="13.2b | 13.2c" marks="10 marks" time="12" ttext="Arithmetic series | Geometric series"></q>
<q index1="|A.I$|D.A.A$|F.E$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q13W.C2.07" qid="Q13W.C2.07" des="Transformation/sketch/log soln" index7="13.1a | 13.1b | 13.4b" marks="9 marks" time="11" ttext="Surds/indices | Polynomials | Logarithmic function"></q>
<q index1="|H.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q13W.C2.08" qid="Q13W.C2.08" des="2 binom expansions; term in product" index7="13.2d" marks="9 marks" time="11" ttext="Binomial expansion"></q>
<q index1="|A.H$|J|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q13W.C2.09" qid="Q13W.C2.09" des="Soln trig eqns (incl transf)" index7="13.3c | 13.3d" marks="12 marks" time="14" ttext="Transformation of graphs | Trigonometry"></q>
<q index1="|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q13W.C3.01" qid="Q13W.C3.01" des="Simple iteration to find 3rd term" index7="14.6b" marks="5 marks" time="6" ttext="Numerical methods"></q>
<q index1="|D.B|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q13W.C3.02" qid="Q13W.C3.02" des="Simpson; exact value/std ln" index7="14.5a | 14.6c" marks="9 marks" time="11" ttext="Integration"></q>
<q index1="|D.A|D.A.C$|D.A.D$|D.A.E$|D.A.J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q13W.C3.03" qid="Q13W.C3.03" des="Std derivatives incl quot(trig fns)" index7="14.4a | 14.4b" marks="7 marks" time="8" ttext="Differentiation | Trigonometric functions | Exponential functions (differentiation) | Logarithmic functions (differentiation) | Quotients"></q>
<q index1="|A.H$|F.F$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q13W.C3.04" qid="Q13W.C3.04" des="Sketch modulus fn;describe comb transf" index7="14.1b | 14.1c" marks="6 marks" time="7" ttext="Transformation of graphs | Modulus function"></q>
<q index1="|F.A$|F.B$|F.E$|F.F$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q13W.C3.05" qid="Q13W.C3.05" des="Many fn aspects incl combination" index7="14.1a | 14.1b" marks="15 marks" time="18" ttext="Range/domain | Inverse functions | Logarithmic function | Modulus function"></q>
<q index1="|J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q13W.C3.06" qid="Q13W.C3.06" des="Manip leading to eqn/assoc eqn" index7="14.2b | 14.2c" marks="11 marks" time="13" ttext="Trigonometry"></q>
<q index1="|D.A|D.A.C$|D.A.I$|D.B.E$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q13W.C3.07" qid="Q13W.C3.07" des="Eqn tgt/area under curve" index7="14.4a | 14.4b | 14.5b" marks="10 marks" time="12" ttext="Differentiation | Trigonometric functions | Product | Integration by parts"></q>
<q index1="|D.B.B$|D.B.C$|D.B.D$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q13W.C3.08" qid="Q13W.C3.08" des="2 part; std exp int; harder subst" index7="14.5a | 14.5b" marks="12 marks" time="14" ttext="Integration of non-integer powers of x | Integration of exponential functions | Integration by substitution"></q>
<q index1="|A.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q13W.C4.01" qid="Q13W.C4.01" des="Std rem theorem and subsequent factors" index7="15.1a" marks="7 marks" time="8" ttext="Remainder theorem"></q>
<q index1="|H.C$|I.D$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q13W.C4.02" qid="Q13W.C4.02" des="Partial fractions to obtain series" index7="15.1d | 15.3 | 15.3a" marks="11 marks" time="13" ttext="Binomial expansion | Use of partial fractions"></q>
<q index1="|J.A$|J.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q13W.C4.03" qid="Q13W.C4.03" des="R cos(x-a) and double angle formats" index7="15.4a | 15.4b" marks="12 marks" time="14" ttext="Double angle | Sum or diff of 2 angles"></q>
<q index1="|B.B$|D.A|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q13W.C4.04" qid="Q13W.C4.04" des="Basic implicit diff; parametric format" index7="15.2 | 15.6c" marks="8 marks" time="10" ttext="Straight lines | Differentiation"></q>
<q index1="|D.B|D.B.C$|P.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q13W.C4.05" qid="Q13W.C4.05" des="Simp int by sight; DE with var separable" index7="15.6 | 15.6b" marks="9 marks" time="11" ttext="Integration | Integration of exponential functions | Variable separable"></q>
<q index1="|C|C.A$|C.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q13W.C4.06" qid="Q13W.C4.06" des="Basic vector incl eqn line/scalar product" index7="15.7a | 15.7b | 15.7c" marks="15 marks" time="18" ttext="Vectors | Equations of lines | Scalar product"></q>
<q index1="|D.A.D$|D.A.J|F.D$|F.E$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q13W.C4.07" qid="Q13W.C4.07" des="Population model/(max) growth rate" index7="15.5 | 15.6" marks="13 marks" time="16" ttext="Exponential functions (differentiation) | Quotients | Exponential functions | Logarithmic function"></q>
<q index1="|K$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q13W.P1.01" qid="Q13W.P1.01" des="Step-by-step to solve DE" index7="16.6b" marks="5 marks" time="6" ttext="Numerical methods"></q>
<q index1="|L.A$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q13W.P1.02" qid="Q13W.P1.02" des="Complex roots quadratic; manip; conjugate" index7="16.2 | 16.3" marks="9 marks" time="11" ttext="Use of x + iy"></q>
<q index1="|J|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q13W.P1.03" qid="Q13W.P1.03" des="Genl soln of sin(2x + a) = b" index7="16.7" marks="8 marks" time="10" ttext="Trigonometry"></q>
<q index1="|D.B|D.B.B$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q13W.P1.04" qid="Q13W.P1.04" des="Finite value of improper integral" index7="16.5b" marks="4 marks" time="5" ttext="Integration | Integration of non-integer powers of x"></q>
<q index1="|A.F$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q13W.P1.05" qid="Q13W.P1.05" des="Std sum squares; find eqn w assoc roots" index7="16.3" marks="9 marks" time="11" ttext="Roots of quadratic"></q>
<q index1="|M$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q13W.P1.06" qid="Q13W.P1.06" des="Involves multiplic/subtract/geom transf" index7="16.8" marks="12 marks" time="14" ttext="Matrices"></q>
<q index1="|F.E$|F.G$|K$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q13W.P1.07" qid="Q13W.P1.07" des="Std linear law reduction" index7="16.6c" marks="7 marks" time="8" ttext="Logarithmic function | Reduction to linear law | Numerical methods"></q>
<q index1="|I.A$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q13W.P1.08" qid="Q13W.P1.08" des="Use sigma(r^n)/n=3 to 1 to find genl sum" index7="16.4" marks="8 marks" time="10" ttext="Finite series"></q>
<q index1="|A.F$|B.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q13W.P1.09" qid="Q13W.P1.09" des="Basic theory ellipse/ tgt from outside point" index7="16.1d" marks="13 marks" time="16" ttext="Roots of quadratic | Conic sections"></q>
<q index1="|A.F$|F.D$|F.E$|G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q13W.P2.01" qid="Q13W.P2.01" des="Soln of a cosh x + b sinh x = c" index7="17.7" marks="7 marks" time="8" ttext="Roots of quadratic | Exponential functions | Logarithmic function | Hyperbolic functions"></q>
<q index1="|L.A$|L.B$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q13W.P2.02" qid="Q13W.P2.02" des="Int curve/line defined in Argand diag" index7="17.2b" marks="10 marks" time="12" ttext="Use of x + iy | Loci"></q>
<q index1="|A|I.A$|I.B$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q13W.P2.03" qid="Q13W.P2.03" des="Std alg/diff method find sum to infinity" index7="17.5" marks="7 marks" time="8" ttext="Algebra | Finite series | Infinite series"></q>
<q index1="|A.G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q13W.P2.04" qid="Q13W.P2.04" des="Std manip symmetric fns roots cubic" index7="17.1" marks="9 marks" time="11" ttext="Roots of polynomials"></q>
<q index1="|D.A.E$|D.B.E$|F.D$|F.E$|G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q13W.P2.05" qid="Q13W.P2.05" des="Inverse hyp fn in ln form/diff/parts int" index7="17.7" marks="11 marks" time="13" ttext="Logarithmic functions (differentiation) | Integration by parts | Exponential functions | Logarithmic function | Hyperbolic functions"></q>
<q index1="|A|D.A.A$|D.B.G|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q13W.P2.06" qid="Q13W.P2.06" des="Arc length/eqn def param; simple int" index7="17.8" marks="8 marks" time="10" ttext="Algebra | Polynomials | Spot integrals"></q>
<q index1="|A|H.C$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q13W.P2.07" qid="Q13W.P2.07" des="Divisibility test/proved by induct (basic)" index7="17.4" marks="9 marks" time="11" ttext="Algebra | Binomial expansion"></q>
<q index1="|J.D$|L|L.A$|L.C$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q13W.P2.08" qid="Q13W.P2.08" des="Solns z^3=a+ib/area triangle/symm fns" index7="17.1 | 17.2a | 17.2b | 17.3c" marks="14 marks" time="17" ttext="Sine and cosine rules/area of triangle | Complex Numbers | Use of x + iy | De Moivre's Theorem"></q>
<q index1="|K$|P.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q13W.P3.01" qid="Q13W.P3.01" des="Use std/ mod form Euler to find values" index7="18.4 | 18.4c" marks="6 marks" time="7" ttext="Numerical methods | Differential equations - 1st order"></q>
<q index1="|F.D$|H.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q13W.P3.02" qid="Q13W.P3.02" des="Testing prod of e^x expansion/binom " index7="18.1d" marks="5 marks" time="6" ttext="Exponential functions | Binomial expansion"></q>
<q index1="|P.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q13W.P3.03" qid="Q13W.P3.03" des="Find PI when RHS(DE) part of CF" index7="18.5a | 18.5b" marks="5 marks" time="6" ttext="Differential Equations - 2nd order"></q>
<q index1="|I.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q13W.P3.04" qid="Q13W.P3.04" des="Evaluate improper int indic limit process" index7="18.1b | 18.1c" marks="7 marks" time="8" ttext="Improper integrals"></q>
<q index1="|P.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q13W.P3.05" qid="Q13W.P3.05" des="Find integ factor 1st order linear DE" index7="18.4a" marks="8 marks" time="10" ttext="Differential equations - 1st order"></q>
<q index1="|F.E$|I.E$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q13W.P3.06" qid="Q13W.P3.06" des="Macl and ln expansions/limiting form" index7="18.1a | 18.1b | 18.1d" marks="14 marks" time="17" ttext="Logarithmic function | Maclaurin series"></q>
<q index1="|P.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q13W.P3.07" qid="Q13W.P3.07" des="Subst to reduce DE to std 2nd order DE" index7="18.5a | 18.5b" marks="14 marks" time="17" ttext="Differential Equations - 2nd order"></q>
<q index1="|D.B.G|O|O.B$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q13W.P3.08" qid="Q13W.P3.08" des="Build-up to area btwn line/curve" index7="18.2a | 18.2b" marks="16 marks" time="19" ttext="Spot integrals | Polar co-ordinates | Areas"></q>
<q index1="|C.B$|C.C$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q13W.P4.01" qid="Q13W.P4.01" des="Angle between two planes" index7="19.1c" marks="5 marks" time="6" ttext="Equations of planes | Scalar product"></q>
<q index1="|N|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q13W.P4.02" qid="Q13W.P4.02" des="Det AB; det(inv A); find det B;assoc vol" index7="19.4" marks="4 marks" time="5" ttext="Determinants"></q>
<q index1="|C.D$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q13W.P4.03" qid="Q13W.P4.03" des="Vector product/perpendicularity" index7="19.1a | 19.1c" marks="5 marks" time="6" ttext="Vector product"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q13W.P4.04" qid="Q13W.P4.04" des="Matrix products/inverse/soln eqns" index7="19.2a" marks="9 marks" time="11" ttext="Matrices"></q>
<q index1="|N.A$|N.B$|Q$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q13W.P4.05" qid="Q13W.P4.05" des="Basic det tests/lin indep" index7="19.3 | 19.4 | 19.5" marks="9 marks" time="11" ttext="Evaluate determinants | Use and solving equations | Linear independence"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q13W.P4.06" qid="Q13W.P4.06" des="Refl/rotat/comb/invariant pts" index7="19.2c" marks="14 marks" time="17" ttext="Matrices"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q13W.P4.07" qid="Q13W.P4.07" des="Basic eigenvalue/eigenvector tests" index7="19.2d" marks="11 marks" time="13" ttext="Matrices"></q>
<q index1="|C.A$|C.B$|C.D$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q13W.P4.08" qid="Q13W.P4.08" des="Line perp plane/int/vol parallelepiped" index7="19.1a | 19.1c" marks="18 marks" time="22" ttext="Equations of lines | Equations of planes | Vector product"></q>
<q index1="|B.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q13S.C1.01" qid="Q13S.C1.01" des="Line gradient; perp/intersection" index7="12.2a" marks="10 marks" time="12" ttext="Straight lines"></q>
<q index1="|A.I$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q13S.C1.02" qid="Q13S.C1.02" des="Surd simplification/rationalise denom" index7="12.1a" marks="8 marks" time="10" ttext="Surds/indices"></q>
<q index1="|A.H$|B.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q13S.C1.03" qid="Q13S.C1.03" des="Centre/radius/transformation" index7="12.2b" marks="12 marks" time="14" ttext="Transformation of graphs | Circle"></q>
<q index1="|A.A$|D.A.A$|D.A.J.1$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q13S.C1.04" qid="Q13S.C1.04" des="Involves stat points on quartic" index7="12.1e | 12.3b | 12.3c" marks="14 marks" time="17" ttext="Factor theorem | Polynomials | Maxima and minima"></q>
<q index1="|A.C$|B.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q13S.C1.05" qid="Q13S.C1.05" des="Leading to assoc line length" index7="12.1b | 12.2a" marks="8 marks" time="10" ttext="Completing the square | Straight lines"></q>
<q index1="|B.B$|D.B.A$|D.B.G.1$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q13S.C1.06" qid="Q13S.C1.06" des="2-part/eqn tgt/area under curve" index7="12.2c | 12.3a | 12.4b" marks="15 marks" time="18" ttext="Straight lines | Integration of polynomials | Areas and volumes"></q>
<q index1="|A.D$|A.F$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q13S.C1.07" qid="Q13S.C1.07" des="Discriminant/soln assoc inequality" index7="12.1b | 12.1d" marks="8 marks" time="10" ttext="Inequalities | Roots of quadratic"></q>
<q index1="|H.B$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q13S.C2.01" qid="Q13S.C2.01" des="Std GP incl sum to infinity" index7="13.2c" marks="5 marks" time="6" ttext="Geometric series"></q>
<q index1="|J.C$|J.D$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q13S.C2.02" qid="Q13S.C2.02" des="Arc length/sector leading sine rule" index7="13.3a | 13.3b" marks="8 marks" time="10" ttext="Arc length/area of sectors/segments | Sine and cosine rules/area of triangle"></q>
<q index1="|D.B.B$|H.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q13S.C2.03" qid="Q13S.C2.03" des="Binom in x^-2 leading to def int" index7="13.2d | 13.6a" marks="9 marks" time="11" ttext="Integration of non-integer powers of x | Binomial expansion"></q>
<q index1="|F.D$|F.E$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q13S.C2.04" qid="Q13S.C2.04" des="Sketch a^x; solve a^x=b; transf" index7="13.1b | 13.4b" marks="5 marks" time="6" ttext="Exponential functions | Logarithmic function"></q>
<q index1="|A.H$|D.B.H$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q13S.C2.05" qid="Q13S.C2.05" des="Trap rule with transformations" index7="13.1b | 13.6b" marks="9 marks" time="11" ttext="Transformation of graphs | Trapezium rule"></q>
<q index1="|A.I$|B.B$|D.A.B$|D.A.J.1$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q13S.C2.06" qid="Q13S.C2.06" des="Diff to find eqn normal/stat point" index7="13.1a | 13.5" marks="12 marks" time="14" ttext="Surds/indices | Straight lines | Non-integer powers of x | Maxima and minima"></q>
<q index1="|I|I.B$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q13S.C2.07" qid="Q13S.C2.07" des="Recurrence with lim(u(n))" index7="13.2a" marks="6 marks" time="7" ttext="Series and limits | Infinite series"></q>
<q index1="|A.F$|F.E$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q13S.C2.08" qid="Q13S.C2.08" des="Logarithmic manip to quad eqn" index7="13.4a" marks="7 marks" time="8" ttext="Roots of quadratic | Logarithmic function"></q>
<q index1="|A.F$|J|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q13S.C2.09" qid="Q13S.C2.09" des="Knowledge of std trig relationships" index7="13.3c | 13.3d" marks="14 marks" time="17" ttext="Roots of quadratic | Trigonometry"></q>
<q index1="|B.B$|F.F$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q13S.C3.01" qid="Q13S.C3.01" des="Intersection of modulus graphs" index7="14.1b" marks="5 marks" time="6" ttext="Straight lines | Modulus function"></q>
<q index1="|D.A|D.A.I$|D.A.J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q13S.C3.02" qid="Q13S.C3.02" des="Prod and quot diff/incl tan 2x" index7="14.4a | 14.4b" marks="6 marks" time="7" ttext="Differentiation | Product | Quotients"></q>
<q index1="|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q13S.C3.03" qid="Q13S.C3.03" des="Std incl staircase/cobweb" index7="14.6a | 14.6b" marks="6 marks" time="7" ttext="Numerical methods"></q>
<q index1="|A.F$|J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q13S.C3.04" qid="Q13S.C3.04" des="Trig manip (sec x ; tan x) solve eqn" index7="14.2b | 14.2c" marks="7 marks" time="8" ttext="Roots of quadratic | Trigonometry"></q>
<q index1="|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q13S.C3.05" qid="Q13S.C3.05" des="Mid-ord rule to find area/discriminate" index7="14.6c" marks="6 marks" time="7" ttext="Numerical methods"></q>
<q index1="|J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q13S.C3.06" qid="Q13S.C3.06" des="Sketches of inv (cos x) and assoc" index7="14.2a" marks="4 marks" time="5" ttext="Trigonometry"></q>
<q index1="|A.H$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q13S.C3.07" qid="Q13S.C3.07" des="Transforms incl mod and combination" index7="14.1b | 14.1c" marks="9 marks" time="11" ttext="Transformation of graphs"></q>
<q index1="|F.A$|F.B$|F.E$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q13S.C3.08" qid="Q13S.C3.08" des="Std fn qu ; fn of fn" index7="14.1a" marks="12 marks" time="14" ttext="Range/domain | Inverse functions | Logarithmic function"></q>
<q index1="|D.B.A$|D.B.G.1$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q13S.C3.09" qid="Q13S.C3.09" des="Vol rotation about y-axis" index7="14.5 | 14.5c" marks="5 marks" time="6" ttext="Integration of polynomials | Areas and volumes"></q>
<q index1="|D.B.D$|D.B.E$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q13S.C3.10" qid="Q13S.C3.10" des="Integral ln x; (ln x)(ln x); std subst" index7="14.5a | 14.5b" marks="15 marks" time="18" ttext="Integration by substitution | Integration by parts"></q>
<q index1="|D.B.F$|D.B.G.1$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q13S.C4.01" qid="Q13S.C4.01" des="Partial fractions/integration/area under curve" index7="15.1 | 15.1d | 15.6d" marks="10 marks" time="11" ttext="Integration using partial fractions | Areas and volumes"></q>
<q index1="|J.A$|J.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q13S.C4.02" qid="Q13S.C4.02" des="Basic trig testing double angle and cos(A-B)" index7="15.4a | 15.4b" marks="8 marks" time="10" ttext="Double angle | Sum or diff of 2 angles"></q>
<q index1="|H.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q13S.C4.03" qid="Q13S.C4.03" des="Basic exps involving 1+6x and 27+6x" index7="15.3 | 15.3a" marks="7 marks" time="8" ttext="Binomial expansion"></q>
<q index1="|D.A.D$|D.A.H$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q13S.C4.04" qid="Q13S.C4.04" des="Parametric diff with cartesian finale" index7="15.5 | 15.6c" marks="12 marks" time="14" ttext="Exponential functions (differentiation) | Parametric equations"></q>
<q index1="|A.A$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q13S.C4.05" qid="Q13S.C4.05" des="Factor theorem w assoc trig eqn " index7="15.1 | 15.1a | 15.4 | 15.4b" marks="11 marks" time="13" ttext="Factor theorem"></q>
<q index1="|C.A$|C.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q13S.C4.06" qid="Q13S.C4.06" des="Std vector line/perp question" index7="15.7a | 15.7b | 15.7c" marks="14 marks" time="17" ttext="Equations of lines | Scalar product"></q>
<q index1="|P.A$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q13S.C4.07" qid="Q13S.C4.07" des="Prod (basic) diff eqn tide height model/soln" index7="15.6a | 15.6b" marks="3 marks" time="4" ttext="Differential equations - 1st order"></q>
<q index1="|D.B.E$|P.A$|P.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q13S.C4.08" qid="Q13S.C4.08" des="Use int by parts to solve diff eqn" index7="15.6b" marks="10 marks" time="12" ttext="Integration by parts | Differential equations - 1st order | Variable separable"></q>
<q index1="|K$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q13S.P1.01" qid="Q13S.P1.01" des="Newton-Raphson to solve cubic eqn" index7="16.6a" marks="3 marks" time="4" ttext="Numerical methods"></q>
<q index1="|M$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q13S.P1.02" qid="Q13S.P1.02" des="Matrices; add/sub/mult/equate" index7="16.8" marks="7 marks" time="8" ttext="Matrices"></q>
<q index1="|J.B$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q13S.P1.03" qid="Q13S.P1.03" des="Genl soln cos(5x+a)=cos b" index7="16.7" marks="8 marks" time="10" ttext="Sum or diff of 2 angles"></q>
<q index1="|A.E$|L.A$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q13S.P1.04" qid="Q13S.P1.04" des="Conjugate/equality/sim eqns" index7="16.2" marks="7 marks" time="8" ttext="Simultaneous equations | Use of x + iy"></q>
<q index1="|B.B$|D.B.B$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q13S.P1.05" qid="Q13S.P1.05" des="2-part; std grad chord lt/poss improp int" index7="16.5McLean | 16.5b" marks="8 marks" time="10" ttext="Straight lines | Integration of non-integer powers of x"></q>
<q index1="|A|A.F$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q13S.P1.06" qid="Q13S.P1.06" des="Find a^3+b^3; find assoc equation" index7="16.3" marks="11 marks" time="13" ttext="Algebra | Roots of quadratic"></q>
<q index1="|A|K$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q13S.P1.07" qid="Q13S.P1.07" des="2-part; root location/use sigma formulae" index7="16.3 | 16.6" marks="11 marks" time="13" ttext="Algebra | Numerical methods"></q>
<q index1="|M$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q13S.P1.08" qid="Q13S.P1.08" des="Matrix transforms:stretch/reflection" index7="16.8" marks="6 marks" time="7" ttext="Matrices"></q>
<q index1="|F.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q13S.P1.09" qid="Q13S.P1.09" des="Asymptotes/line intersect;root consider" index7="16.1a | 16.1c | 16.3" marks="14 marks" time="17" ttext="Rational functions"></q>
<q index1="|L.B$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q13S.P2.01" qid="Q13S.P2.01" des="Circle; Max values length/angle" index7="17.2b" marks="7 marks" time="8" ttext="Loci"></q>
<q index1="|G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q13S.P2.02" qid="Q13S.P2.02" des="Interpret simp eqn; find stat point" index7="17.7" marks="9 marks" time="11" ttext="Hyperbolic functions"></q>
<q index1="|A|E$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q13S.P2.03" qid="Q13S.P2.03" des="Induction based on sequence defn" index7="17.4" marks="6 marks" time="7" ttext="Algebra | Proof by induction"></q>
<q index1="|I.A$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q13S.P2.04" qid="Q13S.P2.04" des="Method of differences summation" index7="17.5" marks="7 marks" time="8" ttext="Finite series"></q>
<q index1="|A.G$|L.A$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q13S.P2.05" qid="Q13S.P2.05" des="Cubic eqn/complex roots/symm fns manip" index7="17.1 | 17.2 | 17.2a" marks="9 marks" time="11" ttext="Roots of polynomials | Use of x + iy"></q>
<q index1="|D.A|D.A.F$|D.B.D$|G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q13S.P2.06" qid="Q13S.P2.06" des="Hyperb fn qu/int subst/inv tan" index7="17.6 | 17.7" marks="8 marks" time="10" ttext="Differentiation | Inverse trig functions | Integration by substitution | Hyperbolic functions"></q>
<q index1="|D.A|D.B.D$|D.C$|G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q13S.P2.07" qid="Q13S.P2.07" des="Diff inv sinh; use result for CSA using subst" index7="17.7 | 17.8" marks="12 marks" time="14" ttext="Differentiation | Integration by substitution | Arc Length and Area of Surf. Revol | Hyperbolic functions"></q>
<q index1="|A.G$|H.C$|J|L.C$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q13S.P2.08" qid="Q13S.P2.08" des="De M/cos 4x etc; symm fns quartic" index7="17.1 | 17.3a" marks="17 marks" time="20" ttext="Roots of polynomials | Binomial expansion | Trigonometry | De Moivre's Theorem"></q>
<q index1="|K$|P.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q13S.P3.01" qid="Q13S.P3.01" des="Improved Euler formula to give approx" index7="18.4 | 18.4c" marks="5 marks" time="6" ttext="Numerical methods | Differential equations - 1st order"></q>
<q index1="|O.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q13S.P3.02" qid="Q13S.P3.02" des="Given cartesian eqn circle/find polar" index7="18.2a" marks="4 marks" time="5" ttext="Cartesian equations"></q>
<q index1="|D.A.D$|D.A.I$|P.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q13S.P3.03" qid="Q13S.P3.03" des="Find PI (given form)/genl soln/limits" index7="18.5 | 18.5b" marks="12 marks" time="14" ttext="Exponential functions (differentiation) | Product | Differential Equations - 2nd order"></q>
<q index1="|D.B.G|F.E$|I.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q13S.P3.04" qid="Q13S.P3.04" des="Std ln integ/limiting form" index7="18.1b | 18.1c" marks="6 marks" time="7" ttext="Spot integrals | Logarithmic function | Improper integrals"></q>
<q index1="|D.A.E$|D.B.E$|F.D$|F.E$|P.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q13S.P3.05" qid="Q13S.P3.05" des="Solve DE(given IF);partic soln" index7="18.4a" marks="9 marks" time="11" ttext="Logarithmic functions (differentiation) | Integration by parts | Exponential functions | Logarithmic function | Differential equations - 1st order"></q>
<q index1="|D.A.C$|I.E$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q13S.P3.06" qid="Q13S.P3.06" des="Std Maclaurin series/prep leads" index7="18.1a" marks="9 marks" time="11" ttext="Trigonometric functions | Maclaurin series"></q>
<q index1="|A.F$|L.A$|P.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q13S.P3.07" qid="Q13S.P3.07" des="DE transformed to std. 2nd order DE" index7="18.5a | 18.5b" marks="11 marks" time="13" ttext="Roots of quadratic | Use of x + iy | Differential Equations - 2nd order"></q>
<q index1="|D.B|J|J.A$|O.B$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q13S.P3.08" qid="Q13S.P3.08" des="2-part; std int curves/area enclosed" index7="18.2a | 18.2b" marks="19 marks" time="23" ttext="Integration | Trigonometry | Double angle | Areas"></q>
<q index1="|C.B$|C.D$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q13S.P4.01" qid="Q13S.P4.01" des="Cartes eqn plane; vol parallelepiped" index7="19.1a | 19.1c | 19.1d" marks="8 marks" time="10" ttext="Equations of planes | Vector product"></q>
<q index1="|N.B$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q13S.P4.02" qid="Q13S.P4.02" des="Inconsistent eqns;lin dep/indep vactors" index7="19.4 | 19.5" marks="6 marks" time="7" ttext="Use and solving equations"></q>
<q index1="|N|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q13S.P4.03" qid="Q13S.P4.03" des="Factorisation of 3 X 3 det" index7="19.4" marks="8 marks" time="10" ttext="Determinants"></q>
<q index1="|A.E$|C.A$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q13S.P4.04" qid="Q13S.P4.04" des="Int of 2 (caresian) lines; dir cosines line" index7="19.1d | 19.3" marks="10 marks" time="12" ttext="Simultaneous equations | Equations of lines"></q>
<q index1="|M$|N.A$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q13S.P4.05" qid="Q13S.P4.05" des="Eigenvalue/eigenvector tests" index7="19.2d | 19.4" marks="13 marks" time="16" ttext="Matrices | Evaluate determinants"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q13S.P4.06" qid="Q13S.P4.06" des="Effect transform matrix on area/invar lines" index7="19.2b" marks="8 marks" time="10" ttext="Matrices"></q>
<q index1="|M$|N.A$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q13S.P4.07" qid="Q13S.P4.07" des="Non-sing; inverse matrices" index7="19.2a" marks="10 marks" time="12" ttext="Matrices | Evaluate determinants"></q>
<q index1="|C.A$|C.B$|C.C$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q13S.P4.08" qid="Q13S.P4.08" des="Int and angle betw line/plane" index7="19.1c | 19.1d" marks="12 marks" time="14" ttext="Equations of lines | Equations of planes | Scalar product"></q>
<q index1="|B.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q12W.C1.01" qid="Q12W.C1.01" des="Length/gradient/equation/perp" index7="12.2a" marks="11 marks" time="13" ttext="Straight lines"></q>
<q index1="|A.C$|A.F$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q12W.C1.02" qid="Q12W.C1.02" des="Quadratic factors/associated graph/minimum value" index7="12.1b | 12.1f" marks="10 marks" time="12" ttext="Completing the square | Roots of quadratic"></q>
<q index1="|A.I$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q12W.C1.03" qid="Q12W.C1.03" des="Surd squaring/rationalising denom" index7="12.1a" marks="9 marks" time="11" ttext="Surds/indices"></q>
<q index1="|D.A.A$|D.A.J.1$|D.B.A$|D.B.G.1$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q12W.C1.04" qid="Q12W.C1.04" des="Std polynomial diff/integ/tgt eqn/area" index7="12.3a | 12.3b | 12.3c | 12.4a | 12.4b" marks="16 marks" time="19" ttext="Polynomials | Maxima and minima | Integration of polynomials | Areas and volumes"></q>
<q index1="|A.A$|A.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q12W.C1.05" qid="Q12W.C1.05" des="Std applications " index7="12.1e" marks="8 marks" time="10" ttext="Factor theorem | Remainder theorem"></q>
<q index1="|A.D$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q12W.C1.06" qid="Q12W.C1.06" des="Simple inequalities/linear and quadratic" index7="12.1d" marks="7 marks" time="8" ttext="Inequalities"></q>
<q index1="|B.A$|B.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q12W.C1.07" qid="Q12W.C1.07" des="Genl circle theory/(tgt) line int" index7="12.2a | 12.2b" marks="14 marks" time="17" ttext="Circle | Straight lines"></q>
<q index1="|J.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q12W.C2.01" qid="Q12W.C2.01" des="Std sector area/length of curve" index7="13.3b" marks="4 marks" time="5" ttext="Arc length/area of sectors/segments"></q>
<q index1="|D.B.H$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q12W.C2.02" qid="Q12W.C2.02" des="Trapezium rule with poss accuracy increase" index7="13.6b" marks="5 marks" time="6" ttext="Trapezium rule"></q>
<q index1="|A.I$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q12W.C2.03" qid="Q12W.C2.03" des="Alternate forms and division" index7="13.1a" marks="3 marks" time="4" ttext="Surds/indices"></q>
<q index1="|I|J.D$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q12W.C2.04" qid="Q12W.C2.04" des="Both rules/area formula tested" index7="13.3a" marks="8 marks" time="10" ttext="Series and limits | Sine and cosine rules/area of triangle"></q>
<q index1="|A.H$|H.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q12W.C2.05" qid="Q12W.C2.05" des="Basic transformation/includes bin" index7="13.1b | 13.2d" marks="8 marks" time="10" ttext="Transformation of graphs | Binomial expansion"></q>
<q index1="|A.E$|H.A$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q12W.C2.06" qid="Q12W.C2.06" des="Std AP/sigma notation/sum n terms" index7="13.2b" marks="10 marks" time="12" ttext="Simultaneous equations | Arithmetic series"></q>
<q index1="|B.C$|F.E$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q12W.C2.07" qid="Q12W.C2.07" des="Soln a^x=b/logarithmic manip" index7="13.4a | 13.4b" marks="10 marks" time="12" ttext="Conic sections | Logarithmic function"></q>
<q index1="|J|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q12W.C2.08" qid="Q12W.C2.08" des="sin/cos=tan and Pythag relation" index7="13.3c | 13.3d" marks="10 marks" time="12" ttext="Trigonometry"></q>
<q index1="|B.B$|D.A|D.A.B$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q12W.C2.09" qid="Q12W.C2.09" des="Eqn tgt/area betwn curve and line" index7="13.5 | 13.6a" marks="17 marks" time="10" ttext="Straight lines | Differentiation | Non-integer powers of x"></q>
<q index1="|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q12W.C3.01" qid="Q12W.C3.01" des="Simpson; std simp iteration" index7="14.6a | 14.6b | 14.6c" marks="8 marks" time="10" ttext="Numerical methods"></q>
<q index1="|A.F$|F.A$|F.B$|F.C$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q12W.C3.02" qid="Q12W.C3.02" des="Std function tests incl fn of fn" index7="14.1a" marks="11 marks" time="13" ttext="Roots of quadratic | Range/domain | Inverse functions | Rational functions"></q>
<q index1="|D.A|D.A.A$|D.B|F.E$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q12W.C3.03" qid="Q12W.C3.03" des="Simple deriv leading to ln for integration" index7="14.3b | 14.4 | 14.5a" marks="6 marks" time="7" ttext="Differentiation | Polynomials | Integration | Logarithmic function"></q>
<q index1="|A.F$|J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q12W.C3.04" qid="Q12W.C3.04" des="Eqn in sec x leading to assoc eqn" index7="14.2b | 14.2c" marks="9 marks" time="11" ttext="Roots of quadratic | Trigonometry"></q>
<q index1="|F.E$|F.F$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q12W.C3.05" qid="Q12W.C3.05" des="Describe seq trans; also sketch/ineq." index7="14.1b | 14.1c | 14.3b" marks="13 marks" time="16" ttext="Logarithmic function | Modulus function"></q>
<q index1="|D.A.C$|D.A.J|D.B.D$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q12W.C3.06" qid="Q12W.C3.06" des="Deriv(cosec) leading to simple subst integration" index7="14.2b | 14.2c | 14.4a | 14.4b | 14.5a | 14.5b" marks="12 marks" time="14" ttext="Trigonometric functions | Quotients | Integration by substitution"></q>
<q index1="|D.A|D.A.D$|D.A.I$|D.B|D.B.E$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q12W.C3.07" qid="Q12W.C3.07" des="Involved qu on stat pts/double int by parts" index7="14.4a | 14.4b | 14.5a | 14.5b" marks="16 marks" time="19" ttext="Differentiation | Exponential functions (differentiation) | Product | Integration | Integration by parts"></q>
<q index1="|D.B.F$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q12W.C4.01" qid="Q12W.C4.01" des="PFs;inc extension w long div; def int" index7="15.1c | 15.1d | 15.6d" marks="11 marks" time="13" ttext="Integration using partial fractions"></q>
<q index1="|J.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q12W.C4.02" qid="Q12W.C4.02" des="Std; given cos A find tan A / tan(A+B)" index7="15.4 | 15.4a" marks="6 marks" time="7" ttext="Sum or diff of 2 angles"></q>
<q index1="|H.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q12W.C4.03" qid="Q12W.C4.03" des="Bin exp using (a+bx); numerical ext" index7="15.3a" marks="7 marks" time="8" ttext="Binomial expansion"></q>
<q index1="|A.F$|F.D$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q12W.C4.04" qid="Q12W.C4.04" des="Growth model; Soln a exp x + b exp(-x) = c reqd " index7="15.5" marks="9 marks" time="11" ttext="Roots of quadratic | Exponential functions"></q>
<q index1="|B|D.A.H$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q12W.C4.05" qid="Q12W.C4.05" des="Parametric eqns; cartesian and tgt reqd" index7="15.2 | 15.6c" marks="11 marks" time="13" ttext="Co-ordinate geometry | Parametric equations"></q>
<q index1="|A.A$|J.A$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q12W.C4.06" qid="Q12W.C4.06" des="Factor th to solve assoc trig eqn w doub angles" index7="15.4b" marks="10 marks" time="12" ttext="Factor theorem | Double angle"></q>
<q index1="|D.B.E$|P.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q12W.C4.07" qid="Q12W.C4.07" des="Variables sep d.e. requires int by parts" index7="15.6b" marks="9 marks" time="11" ttext="Integration by parts | Variable separable"></q>
<q index1="|C.A$|C.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q12W.C4.08" qid="Q12W.C4.08" des="Std vector incl angle betw 2 lines/perp/scalar prod" index7="15.7a | 15.7b | 15.7c" marks="12 marks" time="14" ttext="Equations of lines | Scalar product"></q>
<q index1="|A.F$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q12W.P1.01" qid="Q12W.P1.01" des="Given roots/find asssociated roots eqn" index7="16.3" marks="9 marks" time="11" ttext="Roots of quadratic"></q>
<q index1="|D.B.B$|I.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q12W.P1.02" qid="Q12W.P1.02" des="Determine which integral has finite value" index7="16.5b" marks="5 marks" time="6" ttext="Integration of non-integer powers of x | Improper integrals"></q>
<q index1="|A.F$|L.A$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q12W.P1.03" qid="Q12W.P1.03" des="Simple complex roots/complex manip" index7="16.2" marks="8 marks" time="10" ttext="Roots of quadratic | Use of x + iy"></q>
<q index1="|I.A$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q12W.P1.04" qid="Q12W.P1.04" des="Sigma notation/standard results" index7="16.4" marks="7 marks" time="8" ttext="Finite series"></q>
<q index1="|K$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q12W.P1.05" qid="Q12W.P1.05" des="Tesing basic lin interp/Newton Raphson" index7="16.6a" marks="7 marks" time="8" ttext="Numerical methods"></q>
<q index1="|J|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q12W.P1.06" qid="Q12W.P1.06" des="General solns of tan(ax - b) = c" index7="16.7" marks="7 marks" time="8" ttext="Trigonometry"></q>
<q index1="|A.H$|B.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q12W.P1.07" qid="Q12W.P1.07" des="Hyperbola/asymptotes/translated format" index7="16.1d" marks="12 marks" time="14" ttext="Transformation of graphs | Conic sections"></q>
<q index1="|A.H$|M$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q12W.P1.08" qid="Q12W.P1.08" des="Transformed rectangle with further transform" index7="16.8" marks="8 marks" time="10" ttext="Transformation of graphs | Matrices"></q>
<q index1="|A.E$|A.F$|B.B$|B.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q12W.P1.09" qid="Q12W.P1.09" des="Hyp; genl line intersection/hence tgt" index7="16.1a | 16.1d" marks="12 marks" time="14" ttext="Simultaneous equations | Roots of quadratic | Straight lines | Conic sections"></q>
<q index1="|A.F$|F.D$|F.E$|G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q12W.P2.01" qid="Q12W.P2.01" des="Sketch/int 2 simp hyp curves; expo work" index7="17.7" marks="8 marks" time="10" ttext="Roots of quadratic | Exponential functions | Logarithmic function | Hyperbolic functions"></q>
<q index1="|L.A$|L.B$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q12W.P2.02" qid="Q12W.P2.02" des="Simp arg z part/rem geom/trig of circle" index7="17.2b" marks="8 marks" time="10" ttext="Use of x + iy | Loci"></q>
<q index1="|D.A.E$|D.C$|G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q12W.P2.03" qid="Q12W.P2.03" des="Deriv(tanh); arc length based prev result" index7="17.7 | 17.8" marks="12 marks" time="14" ttext="Logarithmic functions (differentiation) | Arc Length and Area of Surf. Revol | Hyperbolic functions"></q>
<q index1="|A|E$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q12W.P2.04" qid="Q12W.P2.04" des="(Std) induction for nth term sequence" index7="17.4" marks="6 marks" time="7" ttext="Algebra | Proof by induction"></q>
<q index1="|A.E$|L.C$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q12W.P2.05" qid="Q12W.P2.05" des="De Moivre leading to simp pair eqns" index7="17.3a" marks="7 marks" time="8" ttext="Simultaneous equations | De Moivre's Theorem"></q>
<q index1="|A.C$|D.A.F$|D.B.D$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q12W.P2.06" qid="Q12W.P2.06" des="Subst (not given) leading to inv tan" index7="17.6" marks="8 marks" time="10" ttext="Completing the square | Inverse trig functions | Integration by substitution"></q>
<q index1="|A|A.G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q12W.P2.07" qid="Q12W.P2.07" des="Based on symm fns of roots cubic eqn" index7="17.1 | 17.2a" marks="12 marks" time="14" ttext="Algebra | Roots of polynomials"></q>
<q index1="|A.F$|L.A$|L.C$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q12W.P2.08" qid="Q12W.P2.08" des="Manip of roots (factors) of z^5 = 1" index7="17.3b" marks="14 marks" time="17" ttext="Roots of quadratic | Use of x + iy | De Moivre's Theorem"></q>
<q index1="|K$|P.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q12W.P3.01" qid="Q12W.P3.01" des="Std use Euler/modified for approx" index7="18.4c" marks="6 marks" time="7" ttext="Numerical methods | Differential equations - 1st order"></q>
<q index1="|D.A.B$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q12W.P3.02" qid="Q12W.P3.02" des="Simple limit rational " index7="18.1b" marks="3 marks" time="4" ttext="Non-integer powers of x"></q>
<q index1="|A.F$|P.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q12W.P3.03" qid="Q12W.P3.03" des="Complex roots Aux Eqn; std PI" index7="18.5 | 18.5a | 18.5b" marks="10 marks" time="12" ttext="Roots of quadratic | Differential Equations - 2nd order"></q>
<q index1="|D.B.E$|F.D$|F.E$|P.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q12W.P3.04" qid="Q12W.P3.04" des="Std type IF leading to int by parts" index7="18.4 | 18.4a" marks="10 marks" time="12" ttext="Integration by parts | Exponential functions | Logarithmic function | Differential equations - 1st order"></q>
<q index1="|D.A.D$|D.A.I$|D.B.D$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q12W.P3.05" qid="Q12W.P3.05" des="Subst to eval improper int/limiting form" index7="18.1b | 18.1c" marks="8 marks" time="10" ttext="Exponential functions (differentiation) | Product | Integration by substitution"></q>
<q index1="|D.A|D.A.C$|D.A.E$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q12W.P3.06" qid="Q12W.P3.06" des="Macl exp based on ln(cos 2x)/extension" index7="18.1a" marks="11 marks" time="13" ttext="Differentiation | Trigonometric functions | Logarithmic functions (differentiation)"></q>
<q index1="|A.F$|P.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q12W.P3.07" qid="Q12W.P3.07" des="Subst to std 2nd order DE/equal roots AE" index7="18.5a | 18.5b" marks="12 marks" time="14" ttext="Roots of quadratic | Differential Equations - 2nd order"></q>
<q index1="|J.C$|O.A$|O.B$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q12W.P3.08" qid="Q12W.P3.08" des="Area bounded/cartesian to polar/int" index7="18.2a | 18.2b" marks="15 marks" time="18" ttext="Arc length/area of sectors/segments | Cartesian equations | Areas"></q>
<q index1="|C.C$|C.D$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q12W.P4.01" qid="Q12W.P4.01" des="Basic vector alg inv scalar/vector products" index7="19.1c" marks="5 marks" time="6" ttext="Scalar product | Vector product"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q12W.P4.02" qid="Q12W.P4.02" des="Describe transformation rep by matrix" index7="19.2c" marks="5 marks" time="6" ttext="Matrices"></q>
<q index1="|M$|N.A$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q12W.P4.03" qid="Q12W.P4.03" des="Eigenvalue/vector test; inv pt transform" index7="19.2d | 19.4" marks="7 marks" time="8" ttext="Matrices | Evaluate determinants"></q>
<q index1="|A|M$|N.A$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q12W.P4.04" qid="Q12W.P4.04" des="Transpose; products/(factors of) det" index7="19.2a | 19.4" marks="7 marks" time="8" ttext="Algebra | Matrices | Evaluate determinants"></q>
<q index1="|N.A$|N.B$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q12W.P4.05" qid="Q12W.P4.05" des="Uniqueness solns 3 eqns; interp geom" index7="19.4" marks="10 marks" time="12" ttext="Evaluate determinants | Use and solving equations"></q>
<q index1="|C.B$|C.C$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q12W.P4.06" qid="Q12W.P4.06" des="Angle betw/cart eqn int of 2 planes" index7="19.1d" marks="16 marks" time="19" ttext="Equations of planes | Scalar product"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q12W.P4.07" qid="Q12W.P4.07" des="Rotation matrix applied to hyperbola" index7="19.2a | 19.2b" marks="16 marks" time="19" ttext="Matrices"></q>
<q index1="|N|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q12W.P4.08" qid="Q12W.P4.08" des="Determinant factors (or sc.tr.pr)" index7="19.4 | 19.5" marks="9 marks" time="11" ttext="Determinants"></q>
<q index1="|A.I$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q12S.C1.01" qid="Q12S.C1.01" des="Surd denom rationalisation" index7="12.1a" marks="4 marks" time="5" ttext="Surds/indices"></q>
<q index1="|A.E$|B.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q12S.C1.02" qid="Q12S.C1.02" des="Lines: grad/parallel/eqn/int" index7="12.2a" marks="10 marks" time="12" ttext="Simultaneous equations | Straight lines"></q>
<q index1="|A.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q12S.C1.03" qid="Q12S.C1.03" des="Factor th/sketch assoc curve" index7="12.1e | 12.1f" marks="10 marks" time="12" ttext="Factor theorem"></q>
<q index1="|D.A|D.A.J.1$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q12S.C1.04" qid="Q12S.C1.04" des="Stat value vol of cuboid; 2nd deriv" index7="12.3a | 12.3b | 12.3c" marks="10 marks" time="12" ttext="Differentiation | Maxima and minima"></q>
<q index1="|A.C$|D.B.G.1$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q12S.C1.05" qid="Q12S.C1.05" des="Axis symmetry/area btwn line/curve" index7="12.1b | 12.4b" marks="13 marks" time="16" ttext="Completing the square | Areas and volumes"></q>
<q index1="|B.A$|B.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q12S.C1.06" qid="Q12S.C1.06" des="Std circle/eqn/tgt/line length/area" index7="12.2a | 12.2b | 12.2c" marks="13 marks" time="16" ttext="Circle | Straight lines"></q>
<q index1="|A.D$|D.A|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q12S.C1.07" qid="Q12S.C1.07" des="Increasing grads; int tgt/normal" index7="12.1d | 12.2c | 12.3b" marks="15 marks" time="18" ttext="Inequalities | Differentiation"></q>
<q index1="|H.A$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q12S.C2.01" qid="Q12S.C2.01" des="Std AP/find d;u(100);S(280)" index7="13.2b" marks="5 marks" time="6" ttext="Arithmetic series"></q>
<q index1="|J.D$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q12S.C2.02" qid="Q12S.C2.02" des="Std involves sin^2+cos^2=1" index7="13.3a | 13.3c" marks="6 marks" time="7" ttext="Sine and cosine rules/area of triangle"></q>
<q index1="|D.B.B$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q12S.C2.03" qid="Q12S.C2.03" des="Basic exp leading to definite int" index7="13.6a" marks="7 marks" time="8" ttext="Integration of non-integer powers of x"></q>
<q index1="|H.B$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q12S.C2.04" qid="Q12S.C2.04" des="Std GP; sum to infinity/manipulation" index7="13.2c" marks="8 marks" time="10" ttext="Geometric series"></q>
<q index1="|J.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q12S.C2.05" qid="Q12S.C2.05" des="Involves area enclosed by circle tgts" index7="13.3b" marks="9 marks" time="11" ttext="Arc length/area of sectors/segments"></q>
<q index1="|D.B|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q12S.C2.06" qid="Q12S.C2.06" des="Given grad/find curve eqn;max/min" index7="13.6" marks="10 marks" time="12" ttext="Integration"></q>
<q index1="|J|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q12S.C2.07" qid="Q12S.C2.07" des="Non std trig eqn" index7="13.3c | 13.3d" marks="7 marks" time="8" ttext="Trigonometry"></q>
<q index1="|A.F$|F.E$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q12S.C2.08" qid="Q12S.C2.08" des="Quad eqn in 7^x; logs needed" index7="13.1a | 13.4b" marks="8 marks" time="10" ttext="Roots of quadratic | Logarithmic function"></q>
<q index1="|D.B.H$|F.E$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q12S.C2.09" qid="Q12S.C2.09" des="Trap rule inv transformations/logs" index7="13.1b | 13.4a | 13.6b" marks="15 marks" time="18" ttext="Trapezium rule | Logarithmic function"></q>
<q index1="|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q12S.C3.01" qid="Q12S.C3.01" des="Std mid-ordinate rule (care needed)" index7="14.6c" marks="4 marks" time="5" ttext="Numerical methods"></q>
<q index1="|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q12S.C3.02" qid="Q12S.C3.02" des="Also involving cobweb or staircase" index7="14.6a | 14.6b" marks="7 marks" time="8" ttext="Numerical methods"></q>
<q index1="|D.A|D.A.E$|D.A.I$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q12S.C3.03" qid="Q12S.C3.03" des="Product rule to find eqn tgt; int with x axis" index7="14.4a | 14.4b" marks="7 marks" time="8" ttext="Differentiation | Logarithmic functions (differentiation) | Product"></q>
<q index1="|D.A|D.A.D$|D.B|D.B.E$|D.B.G.1$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q12S.C3.04" qid="Q12S.C3.04" des="Simp int by parts leading to vol of revol" index7="14.5 | 14.5b | 14.5c" marks="7 marks" time="8" ttext="Differentiation | Exponential functions (differentiation) | Integration | Integration by parts | Areas and volumes"></q>
<q index1="|F.A$|F.B$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q12S.C3.05" qid="Q12S.C3.05" des="Std fn qu incl range/composition/inverse" index7="14.1 | 14.1a" marks="10 marks" time="12" ttext="Range/domain | Inverse functions"></q>
<q index1="|D.B|D.B.B$|D.B.D$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q12S.C3.06" qid="Q12S.C3.06" des="Subst (care needed) leading to int (1/u)" index7="14.5a | 14.5b" marks="6 marks" time="7" ttext="Integration | Integration of non-integer powers of x | Integration by substitution"></q>
<q index1="|A.H$|F.F$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q12S.C3.07" qid="Q12S.C3.07" des="Qu based on sketches mod f(x) and f(mod x)" index7="14.1 | 14.1b | 14.1c" marks="11 marks" time="13" ttext="Transformation of graphs | Modulus function"></q>
<q index1="|J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q12S.C3.08" qid="Q12S.C3.08" des="Simp trig manip leading to harder assoc eqn" index7="14.2b | 14.2c" marks="9 marks" time="11" ttext="Trigonometry"></q>
<q index1="|D.A|D.A.C$|D.A.E$|D.A.J|D.A.J.1$|J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q12S.C3.09" qid="Q12S.C3.09" des="Involved (but easy) qu testing stat points " index7="14.2a | 14.2c | 14.4a | 14.4b" marks="14 marks" time="17" ttext="Differentiation | Trigonometric functions | Logarithmic functions (differentiation) | Quotients | Maxima and minima | Trigonometry"></q>
<q index1="|D.B.F$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q12S.C4.01" qid="Q12S.C4.01" des="2-part; PFS and integ; (effectively) long div " index7="15.1b | 15.1c | 15.1d | 15.6d" marks="11 marks" time="13" ttext="Integration using partial fractions"></q>
<q index1="|J|J.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q12S.C4.02" qid="Q12S.C4.02" des="Use Rsin(x-k) to solve a cos x + b sin x = c " index7="15.4a" marks="7 marks" time="8" ttext="Trigonometry | Sum or diff of 2 angles"></q>
<q index1="|H|H.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q12S.C4.03" qid="Q12S.C4.03" des="Product of 2 binom expansions" index7="15.3 | 15.3a" marks="8 marks" time="10" ttext="Sequences and series | Binomial expansion"></q>
<q index1="|F.E$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q12S.C4.04" qid="Q12S.C4.04" des="Std investment model using lns" index7="15.5" marks="8 marks" time="10" ttext="Logarithmic function"></q>
<q index1="|B.B$|D.A.H$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q12S.C4.05" qid="Q12S.C4.05" des="(Trig) para eqn curve; eqn normal; cartesian" index7="15.2 | 15.6c" marks="9 marks" time="11" ttext="Straight lines | Parametric equations"></q>
<q index1="|D.A.G$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q12S.C4.06" qid="Q12S.C4.06" des="Stat pts of curve defined implicitly" index7="15.6c" marks="8 marks" time="10" ttext="Implicit functions"></q>
<q index1="|C.A$|C.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q12S.C4.07" qid="Q12S.C4.07" des="Vector lines intersection/perp/sc prod" index7="15.7a | 15.7b | 15.7c" marks="12 marks" time="14" ttext="Equations of lines | Scalar product"></q>
<q index1="|P.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q12S.C4.08" qid="Q12S.C4.08" des="Form diff eqn; solve variables sep" index7="15.6a | 15.6b" marks="12 marks" time="14" ttext="Variable separable"></q>
<q index1="|A.F$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q12S.P1.01" qid="Q12S.P1.01" des="Given roots quadratic/find eqn assoc roots" index7="16.3" marks="10 marks" time="12" ttext="Roots of quadratic"></q>
<q index1="|B.B$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q12S.P1.02" qid="Q12S.P1.02" des="Use chord grad to find curve grad" index7="16.5McLean" marks="7 marks" time="8" ttext="Straight lines"></q>
<q index1="|A.E$|L.A$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q12S.P1.03" qid="Q12S.P1.03" des="Complex conj used in soln eqn" index7="16.2" marks="6 marks" time="7" ttext="Simultaneous equations | Use of x + iy"></q>
<q index1="|J|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q12S.P1.04" qid="Q12S.P1.04" des="Genl soln sin(a - bx) = c" index7="16.7" marks="6 marks" time="7" ttext="Trigonometry"></q>
<q index1="|A.D$|A.F$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q12S.P1.05" qid="Q12S.P1.05" des="Asyms of curve/line int to solve ineq" index7="16.1a | 16.1b" marks="11 marks" time="13" ttext="Inequalities | Roots of quadratic"></q>
<q index1="|M$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q12S.P1.06" qid="Q12S.P1.06" des="Matrix theory applied to transf" index7="16.8" marks="11 marks" time="13" ttext="Matrices"></q>
<q index1="|D.A.A$|K$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q12S.P1.07" qid="Q12S.P1.07" des="Interval bisect/Newton Raphson test" index7="16.6a" marks="9 marks" time="11" ttext="Polynomials | Numerical methods"></q>
<q index1="|A.F$|A.H$|B.B$|B.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q12S.P1.08" qid="Q12S.P1.08" des="Ellipse translated to touch line" index7="16.1 | 16.1d" marks="15 marks" time="18" ttext="Roots of quadratic | Transformation of graphs | Straight lines | Conic sections"></q>
<q index1="|A.F$|F.D$|F.E$|G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q12S.P2.01" qid="Q12S.P2.01" des="Quad eqn in cosh x; solns in ln format" index7="17.7" marks="7 marks" time="8" ttext="Roots of quadratic | Exponential functions | Logarithmic function | Hyperbolic functions"></q>
<q index1="|L|L.B$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q12S.P2.02" qid="Q12S.P2.02" des="Arg diag with circle/ perp bis; " index7="17.2b" marks="7 marks" time="8" ttext="Complex Numbers | Loci"></q>
<q index1="|I.A$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q12S.P2.03" qid="Q12S.P2.03" des="Summation using method of differences" index7="17.5" marks="6 marks" time="7" ttext="Finite series"></q>
<q index1="|A.G$|L.A$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q12S.P2.04" qid="Q12S.P2.04" des="Symm fns of roots of cubic eqn" index7="17.1" marks="13 marks" time="16" ttext="Roots of polynomials | Use of x + iy"></q>
<q index1="|D.A.F$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q12S.P2.05" qid="Q12S.P2.05" des="Connection betw inv trig fns; differentiation" index7="17.6" marks="6 marks" time="7" ttext="Inverse trig functions"></q>
<q index1="|D.C$|G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q12S.P2.06" qid="Q12S.P2.06" des="Based on cosh 4x/cosh 2x/CSArea" index7="17.7 | 17.8" marks="13 marks" time="16" ttext="Arc Length and Area of Surf. Revol | Hyperbolic functions"></q>
<q index1="|E$|I.A$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q12S.P2.07" qid="Q12S.P2.07" des="Std induction on sum finite series" index7="17.4 | 17.5" marks="9 marks" time="11" ttext="Proof by induction | Finite series"></q>
<q index1="|L.C$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q12S.P2.08" qid="Q12S.P2.08" des="De Moivre to work with (cos 2x)^4" index7="17.3a" marks="14 marks" time="17" ttext="De Moivre's Theorem"></q>
<q index1="|K$|P.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q12S.P3.01" qid="Q12S.P3.01" des="Euler/improved Euler for approxs" index7="18.4c" marks="5 marks" time="6" ttext="Numerical methods | Differential equations - 1st order"></q>
<q index1="|I|I.E$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q12S.P3.02" qid="Q12S.P3.02" des="Use ln and sin exps to find limit rat fn" index7="18.1b | 18.1d" marks="5 marks" time="6" ttext="Series and limits | Maclaurin series"></q>
<q index1="|D.B|O|O.B$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q12S.P3.03" qid="Q12S.P3.03" des="Area region/involves integral tan x" index7="18.2a | 18.2b" marks="4 marks" time="5" ttext="Integration | Polar co-ordinates | Areas"></q>
<q index1="|D.A.J.1$|D.B.G|P.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q12S.P3.04" qid="Q12S.P3.04" des="Int factor for soln DE/stat point extension" index7="18.4 | 18.4a" marks="10 marks" time="12" ttext="Maxima and minima | Spot integrals | Differential equations - 1st order"></q>
<q index1="|D.B.E$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q12S.P3.05" qid="Q12S.P3.05" des="(Double) int by parts; limiting process" index7="18.1b | 18.1c" marks="7 marks" time="8" ttext="Integration by parts"></q>
<q index1="|D.A.C$|D.A.E$|D.A.J|F.D$|F.E$|I.E$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q12S.P3.06" qid="Q12S.P3.06" des="Find Macl exp of ln(1 + sin x)" index7="18.1a" marks="11 marks" time="13" ttext="Trigonometric functions | Logarithmic functions (differentiation) | Quotients | Exponential functions | Logarithmic function | Maclaurin series"></q>
<q index1="|D.A.D$|D.A.I$|P.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q12S.P3.07" qid="Q12S.P3.07" des="Subst to transform into std 2nd order DE" index7="18.5a | 18.5b" marks="19 marks" time="23" ttext="Exponential functions (differentiation) | Product | Differential Equations - 2nd order"></q>
<q index1="|O.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q12S.P3.08" qid="Q12S.P3.08" des="Cart to polar/closest pt/int curves" index7="18.2a" marks="14 marks" time="17" ttext="Cartesian equations"></q>
<q index1="|A.E$|C|N.B$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q12S.P4.01" qid="Q12S.P4.01" des="Basic linear dependency test" index7="19.1 | 19.4 | 19.5" marks="3 marks" time="4" ttext="Simultaneous equations | Vectors | Use and solving equations"></q>
<q index1="|C.A$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q12S.P4.02" qid="Q12S.P4.02" des="Determine dir cosines of line/geom interp" index7="19.1 | 19.1c" marks="4 marks" time="5" ttext="Equations of lines"></q>
<q index1="|N|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q12S.P4.03" qid="Q12S.P4.03" des="Factorisation of 3 X 3 determinant" index7="19.4" marks="6 marks" time="7" ttext="Determinants"></q>
<q index1="|C.A$|C.C$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q12S.P4.04" qid="Q12S.P4.04" des="Vector perp 2 lines; shortest dist betwn" index7="19.1c" marks="10 marks" time="12" ttext="Equations of lines | Scalar product"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q12S.P4.05" qid="Q12S.P4.05" des="Eigenvalue/vector test; matrix transf" index7="19.2b | 19.2d" marks="13 marks" time="16" ttext="Matrices"></q>
<q index1="|C.B$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q12S.P4.06" qid="Q12S.P4.06" des="Int of 2 planes/line and plane/geom sig" index7="19.1 | 19.1c | 19.1d" marks="13 marks" time="16" ttext="Equations of planes"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q12S.P4.07" qid="Q12S.P4.07" des="Transpose/prod/inverse/det/eig-val" index7="19.2a | 19.2d" marks="14 marks" time="17" ttext="Matrices"></q>
<q index1="|C.A$|C.B$|C.C$|C.D$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q12S.P4.08" qid="Q12S.P4.08" des="Pt on line/line parallel plane/3-D prob " index7="19.1a | 19.1c" marks="12 marks" time="14" ttext="Equations of lines | Equations of planes | Scalar product | Vector product"></q>
<q index1="|D.A|D.A.A$|D.A.J.1$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q11W.C1.01" qid="Q11W.C1.01" des="Stat point; distinguish max/min" index7="12.3a | 12.3b | 12.3c" marks="10 marks" time="12" ttext="Differentiation | Polynomials | Maxima and minima"></q>
<q index1="|A.I$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q11W.C1.02" qid="Q11W.C1.02" des="Surds; mult and rationalisation" index7="12.1 | 12.1a" marks="5 marks" time="6" ttext="Surds/indices"></q>
<q index1="|B.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q11W.C1.03" qid="Q11W.C1.03" des="Lines; grad/parallel/intersection/length" index7="12.2 | 12.2a" marks="11 marks" time="13" ttext="Straight lines"></q>
<q index1="|B.B$|D.A|D.A.A$|D.B|D.B.A$|D.B.G.1$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q11W.C1.04" qid="Q11W.C1.04" des="Eqn tgt to curve; area btwn curve and line" index7="12.2c | 12.3a | 12.4a | 12.4b" marks="12 marks" time="14" ttext="Straight lines | Differentiation | Polynomials | Integration | Integration of polynomials | Areas and volumes"></q>
<q index1="|A.A$|A.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q11W.C1.05" qid="Q11W.C1.05" des="Cubic; sketch/factorise/solve" index7="12.1 | 12.1e | 12.1f" marks="13 marks" time="16" ttext="Factor theorem | Remainder theorem"></q>
<q index1="|B.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q11W.C1.06" qid="Q11W.C1.06" des="Circle; std eqns; eqn tgt at circum pt" index7="12.2 | 12.2b | 12.2c | 12.2d" marks="13 marks" time="16" ttext="Circle"></q>
<q index1="|A.C$|A.D$|A.E$|A.F$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q11W.C1.07" qid="Q11W.C1.07" des="Complete square;soln quad eqn and inequal" index7="12.1b | 12.1c | 12.1d" marks="11 marks" time="13" ttext="Completing the square | Inequalities | Simultaneous equations | Roots of quadratic"></q>
<q index1="|J.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q11W.C2.01" qid="Q11W.C2.01" des="Std arc length/sector area" index7="13.3 | 13.3b" marks="4 marks" time="5" ttext="Arc length/area of sectors/segments"></q>
<q index1="|A.I$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q11W.C2.02" qid="Q11W.C2.02" des="4 simple eqns based on 2^x = y" index7="13.1 | 13.1a" marks="5 marks" time="6" ttext="Surds/indices"></q>
<q index1="|J.D$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q11W.C2.03" qid="Q11W.C2.03" des="Std cos rule/triangle area; neat final part" index7="13.3 | 13.3a" marks="8 marks" time="10" ttext="Sine and cosine rules/area of triangle"></q>
<q index1="|A.H$|D.B.H$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q11W.C2.04" qid="Q11W.C2.04" des="Std trap rule followed by simp transf" index7="13.1 | 13.1b | 13.6 | 13.6b" marks="6 marks" time="7" ttext="Transformation of graphs | Trapezium rule"></q>
<q index1="|D.B.B$|H.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q11W.C2.05" qid="Q11W.C2.05" des="Basic binomial; integrals of x^1/2 and x^3/2" index7="13.2d | 13.6a" marks="10 marks" time="12" ttext="Integration of non-integer powers of x | Binomial expansion"></q>
<q index1="|F.E$|H.B$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q11W.C2.06" qid="Q11W.C2.06" des="Std GP; also soln of a^n greater than b" index7="13.2c | 13.4b" marks="9 marks" time="11" ttext="Logarithmic function | Geometric series"></q>
<q index1="|A.H$|D.A|D.A.J.1$|D.B.G.1$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q11W.C2.07" qid="Q11W.C2.07" des="Eqn tgt; min pt; area under curve; simp transf" index7="13.1b | 13.5 | 13.6a" marks="16 marks" time="19" ttext="Transformation of graphs | Differentiation | Maxima and minima | Areas and volumes"></q>
<q index1="|F.E$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q11W.C2.08" qid="Q11W.C2.08" des="Logs changed to indices" index7="13.4a" marks="7 marks" time="8" ttext="Logarithmic function"></q>
<q index1="|J|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q11W.C2.09" qid="Q11W.C2.09" des="Use sec^2 = 1+ tan^2 to solve trig eqn" index7="13.3d" marks="10 marks" time="12" ttext="Trigonometry"></q>
<q index1="|D.A|D.A.E$|D.A.I$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q11W.C3.01" qid="Q11W.C3.01" des="Diff involves chain rule/prod/ln x" index7="14.4a | 14.4b" marks="7 marks" time="8" ttext="Differentiation | Logarithmic functions (differentiation) | Product"></q>
<q index1="|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q11W.C3.02" qid="Q11W.C3.02" des="Root location; transformed eqn; iteration" index7="14.6 | 14.6a | 14.6b" marks="6 marks" time="7" ttext="Numerical methods"></q>
<q index1="|D.A.C$|J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q11W.C3.03" qid="Q11W.C3.03" des="Given x=f(y)/find dx/dy; inv tan sketch" index7="14.2a | 14.4a" marks="6 marks" time="7" ttext="Trigonometric functions | Trigonometry"></q>
<q index1="|F.A$|F.B$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q11W.C3.04" qid="Q11W.C3.04" des="Testing most 'Function' features " index7="14.1a | 14.1b | 14.1c" marks="14 marks" time="17" ttext="Range/domain | Inverse functions"></q>
<q index1="|D.B.E$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q11W.C3.05" qid="Q11W.C3.05" des="2-part integration; 1/(a+bx) and 'by parts'" index7="14.5a | 14.5b" marks="6 marks" time="7" ttext="Integration by parts"></q>
<q index1="|D.B.D$|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q11W.C3.06" qid="Q11W.C3.06" des="2-part integraton; substitution/mid-ord" index7="14.5b | 14.6c" marks="10 marks" time="12" ttext="Integration by substitution | Numerical methods"></q>
<q index1="|J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q11W.C3.07" qid="Q11W.C3.07" des="Eqns in sec x and cosec x" index7="14.2b | 14.2c" marks="10 marks" time="12" ttext="Trigonometry"></q>
<q index1="|D.A.D$|D.A.J.1$|D.B.G.1$|F.D$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q11W.C3.08" qid="Q11W.C3.08" des="Simple expo eqns; stat point; volume" index7="14.3a | 14.4a | 14.5c" marks="16 marks" time="19" ttext="Exponential functions (differentiation) | Maxima and minima | Areas and volumes | Exponential functions"></q>
<q index1="|J.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q11W.C4.01" qid="Q11W.C4.01" des="R sin(x + a) format; max value" index7="15.4a" marks="6 marks" time="7" ttext="Sum or diff of 2 angles"></q>
<q index1="|A.A$|A.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q11W.C4.02" qid="Q11W.C4.02" des="2-part; Std use of factor/remainder thms" index7="15.1a | 15.1b" marks="10 marks" time="12" ttext="Factor theorem | Remainder theorem"></q>
<q index1="|H.C$|I.D$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q11W.C4.03" qid="Q11W.C4.03" des="Basic PFs leading to binom exp" index7="15.1d | 15.3b" marks="12 marks" time="14" ttext="Binomial expansion | Use of partial fractions"></q>
<q index1="|D.A.D$|D.A.H$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q11W.C4.04" qid="Q11W.C4.04" des="Parametric eqns/grad/eqn tgt/cartesian" index7="15.6c" marks="6 marks" time="7" ttext="Exponential functions (differentiation) | Parametric equations"></q>
<q index1="|F.D$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q11W.C4.05" qid="Q11W.C4.05" des="Decay involving 2^x; value/eqn/ineq" index7="15.5" marks="7 marks" time="8" ttext="Exponential functions"></q>
<q index1="|J|J.A$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q11W.C4.06" qid="Q11W.C4.06" des="2-part involving tan 2x and cos 2x" index7="15.4b" marks="10 marks" time="12" ttext="Trigonometry | Double angle"></q>
<q index1="|P.A$|P.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q11W.C4.07" qid="Q11W.C4.07" des="Soln of 1st order d.e./variables separable" index7="15.6b" marks="10 marks" time="12" ttext="Differential equations - 1st order | Variable separable"></q>
<q index1="|C|C.A$|C.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q11W.C4.08" qid="Q11W.C4.08" des="Knowledge of r=a+tb; angle betwn lines" index7="15.7b | 15.7c" marks="14 marks" time="17" ttext="Vectors | Equations of lines | Scalar product"></q>
<q index1="|A.F$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q11W.P1.01" qid="Q11W.P1.01" des="Std roots quadratic; alpha^2 and beta^2" index7="16.3" marks="7 marks" time="8" ttext="Roots of quadratic"></q>
<q index1="|I.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q11W.P1.02" qid="Q11W.P1.02" des="Eval of improper integrals (where poss)" index7="16.5b" marks="6 marks" time="7" ttext="Improper integrals"></q>
<q index1="|M$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q11W.P1.03" qid="Q11W.P1.03" des="Knowledge of matrices and assoc transf" index7="16.8" marks="13 marks" time="16" ttext="Matrices"></q>
<q index1="|J|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q11W.P1.04" qid="Q11W.P1.04" des="Genl soln of sin(4x - a) = -b" index7="16.7" marks="6 marks" time="7" ttext="Trigonometry"></q>
<q index1="|L|L.A$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q11W.P1.05" qid="Q11W.P1.05" des="Std manip; conjugate; interesting (c)" index7="16.2" marks="8 marks" time="10" ttext="Complex Numbers | Use of x + iy"></q>
<q index1="|A.H$|B.A$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q11W.P1.06" qid="Q11W.P1.06" des="Find effect of stretch on circle (no matrices)" index7="16.8" marks="8 marks" time="10" ttext="Transformation of graphs | Circle"></q>
<q index1="|A.D$|A.F$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q11W.P1.07" qid="Q11W.P1.07" des="Vert/horiz asyms rational fn; find stat pts(alg)" index7="16.1a | 16.1c" marks="15 marks" time="18" ttext="Inequalities | Roots of quadratic"></q>
<q index1="|I.A$|K$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q11W.P1.08" qid="Q11W.P1.08" des="Std N-Raphson in conjunct sigma(r^2 and r)" index7="16.4 | 16.6a" marks="12 marks" time="14" ttext="Finite series | Numerical methods"></q>
<q index1="|L|L.B$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q11W.P2.01" qid="Q11W.P2.01" des="Std loci including circle and straight line" index7="17.2b" marks="5 marks" time="6" ttext="Complex Numbers | Loci"></q>
<q index1="|I.A$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q11W.P2.02" qid="Q11W.P2.02" des="Use of difference method to sum series" index7="17.5" marks="6 marks" time="7" ttext="Finite series"></q>
<q index1="|A.G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q11W.P2.03" qid="Q11W.P2.03" des="Expand (1+ i)^3; use symm fns roots of cubic" index7="17.1 | 17.2 | 17.2a" marks="11 marks" time="13" ttext="Roots of polynomials"></q>
<q index1="|G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q11W.P2.04" qid="Q11W.P2.04" des="Derivs and expo defns of hyperbolic fns" index7="17.7" marks="11 marks" time="13" ttext="Hyperbolic functions"></q>
<q index1="|D.A|D.A.F$|D.B.E$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q11W.P2.05" qid="Q11W.P2.05" des="Definite integral of inverse sine" index7="17.6" marks="8 marks" time="10" ttext="Differentiation | Inverse trig functions | Integration by parts"></q>
<q index1="|D.A|D.A.C$|D.A.E$|D.C$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q11W.P2.06" qid="Q11W.P2.06" des="Arc length of curve defined parametrically" index7="17.8" marks="10 marks" time="12" ttext="Differentiation | Trigonometric functions | Logarithmic functions (differentiation) | Arc Length and Area of Surf. Revol"></q>
<q index1="|E$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q11W.P2.07" qid="Q11W.P2.07" des="Use induction to prove divisibility" index7="17.4" marks="7 marks" time="8" ttext="Proof by induction"></q>
<q index1="|L.C$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q11W.P2.08" qid="Q11W.P2.08" des="Mod-arg form/cube roots/Argand diag" index7="17.1 | 17.2a | 17.2b | 17.3c" marks="17 marks" time="20" ttext="De Moivre's Theorem"></q>
<q index1="|K$|P.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q11W.P3.01" qid="Q11W.P3.01" des="Std. use of improved Euler formula" index7="18.4c" marks="5 marks" time="6" ttext="Numerical methods | Differential equations - 1st order"></q>
<q index1="|P.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q11W.P3.02" qid="Q11W.P3.02" des="Given format of PI/find genl soln 1st order" index7="18.4a" marks="6 marks" time="7" ttext="Differential equations - 1st order"></q>
<q index1="|O|O.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q11W.P3.03" qid="Q11W.P3.03" des="Given polar form/find cartesn; int line/curve" index7="18.2a" marks="9 marks" time="11" ttext="Polar co-ordinates | Cartesian equations"></q>
<q index1="|P.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q11W.P3.04" qid="Q11W.P3.04" des="Use of integ factor to solve 1st order DE" index7="18.4a" marks="9 marks" time="11" ttext="Differential equations - 1st order"></q>
<q index1="|D.B.F$|I.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q11W.P3.05" qid="Q11W.P3.05" des="(Implied) PFs to find improper integral" index7="18.1c" marks="7 marks" time="8" ttext="Integration using partial fractions | Improper integrals"></q>
<q index1="|O|O.B$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q11W.P3.06" qid="Q11W.P3.06" des="Std area of polar region" index7="18.2 | 18.2b" marks="7 marks" time="8" ttext="Polar co-ordinates | Areas"></q>
<q index1="|D.A.C$|D.A.D$|D.A.I$|F.D$|I.E$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q11W.P3.07" qid="Q11W.P3.07" des="Use Maclaurin/std expansions to find limit" index7="18.1a | 18.1b | 18.1d" marks="9 marks" time="11" ttext="Trigonometric functions | Exponential functions (differentiation) | Product | Exponential functions | Maclaurin series"></q>
<q index1="|P.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q11W.P3.08" qid="Q11W.P3.08" des="Use given subst to transform 2nd order DE" index7="18.5 | 18.5b" marks="18 marks" time="22" ttext="Differential Equations - 2nd order"></q>
<q index1="|N|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q11W.P4.01" qid="Q11W.P4.01" des="Show given exp is factor; factorise det" index7="19.4" marks="4 marks" time="5" ttext="Determinants"></q>
<q index1="|C.C$|C.D$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q11W.P4.02" qid="Q11W.P4.02" des="Use defns vect/sc prods to prove relationship" index7="19.1a" marks="3 marks" time="4" ttext="Scalar product | Vector product"></q>
<q index1="|N|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q11W.P4.03" qid="Q11W.P4.03" des="Uniqueness/consistency of 3 eqns." index7="19.3" marks="6 marks" time="7" ttext="Determinants"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q11W.P4.04" qid="Q11W.P4.04" des="Prod of 2 3 X 3 matrices; inverse (XY) reqd" index7="19.2a" marks="8 marks" time="10" ttext="Matrices"></q>
<q index1="|C|C.A$|C.B$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q11W.P4.05" qid="Q11W.P4.05" des="Eqn intersect line 2 planes;pt intersect 3 planes" index7="19.1 | 19.1c | 19.1d" marks="13 marks" time="16" ttext="Vectors | Equations of lines | Equations of planes"></q>
<q index1="|C|C.A$|C.B$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q11W.P4.06" qid="Q11W.P4.06" des="Eqn line perp plane; dist of pt on line to plane" index7="19.1c | 19.1d" marks="11 marks" time="13" ttext="Vectors | Equations of lines | Equations of planes"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q11W.P4.07" qid="Q11W.P4.07" des="Find eigenvalues and assoc vectors;transf" index7="19.2c | 19.2d" marks="15 marks" time="18" ttext="Matrices"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q11W.P4.08" qid="Q11W.P4.08" des="Connection det/area; invariant pts; refl/shear" index7="19.2b" marks="15 marks" time="18" ttext="Matrices"></q>
<q index1="|B.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q11S.C1.01" qid="Q11S.C1.01" des="Std str line; grad/parallel line eqn/mid-pt" index7="12.2 | 12.2a" marks="9 marks" time="11" ttext="Straight lines"></q>
<q index1="|A.I$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q11S.C1.02" qid="Q11S.C1.02" des="Std manip surds incl rationalisation" index7="12.1 | 12.1a" marks="8 marks" time="10" ttext="Surds/indices"></q>
<q index1="|D.A|D.A.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q11S.C1.03" qid="Q11S.C1.03" des="Rate of change; inc/dec; max/min" index7="12.3a | 12.3b | 12.3c" marks="11 marks" time="13" ttext="Differentiation | Polynomials"></q>
<q index1="|A.C$|A.H$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q11S.C1.04" qid="Q11S.C1.04" des="Compl square;vertex/symmetry line/sketch" index7="12.1 | 12.1b | 12.1f" marks="12 marks" time="14" ttext="Completing the square | Transformation of graphs"></q>
<q index1="|A.A$|A.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q11S.C1.05" qid="Q11S.C1.05" des="Rem/factor theorem; show cubic has 1 root" index7="12.1 | 12.1e" marks="8 marks" time="10" ttext="Factor theorem | Remainder theorem"></q>
<q index1="|D.B|D.B.A$|D.B.G.1$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q11S.C1.06" qid="Q11S.C1.06" des="Find area region betwn curve and line" index7="12.4 | 12.4a | 12.4b" marks="8 marks" time="10" ttext="Integration | Integration of polynomials | Areas and volumes"></q>
<q index1="|A.D$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q11S.C1.07" qid="Q11S.C1.07" des="Soln linear ineq/quad ineq" index7="12.1d" marks="6 marks" time="7" ttext="Inequalities"></q>
<q index1="|B.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q11S.C1.08" qid="Q11S.C1.08" des="Tgt to circle; line int with circle" index7="12.2 | 12.2b | 12.2d" marks="13 marks" time="16" ttext="Circle"></q>
<q index1="|J.D$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q11S.C2.01" qid="Q11S.C2.01" des="Std sine rule and triangle area" index7="13.3a" marks="6 marks" time="7" ttext="Sine and cosine rules/area of triangle"></q>
<q index1="|J.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q11S.C2.02" qid="Q11S.C2.02" des="Simple sector area and arc length" index7="13.3b" marks="6 marks" time="7" ttext="Arc length/area of sectors/segments"></q>
<q index1="|D.B.B$|H.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q11S.C2.03" qid="Q11S.C2.03" des="(Simp) Binomial; def integral/neg indices" index7="13.2d | 13.6a" marks="10 marks" time="12" ttext="Integration of non-integer powers of x | Binomial expansion"></q>
<q index1="|A.H$|F.E$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q11S.C2.04" qid="Q11S.C2.04" des="4^x; sketch/trans; soln of a^x=b" index7="13.1b | 13.4b" marks="10 marks" time="12" ttext="Transformation of graphs | Logarithmic function"></q>
<q index1="|B.B$|D.A|D.A.B$|D.A.J.1$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q11S.C2.05" qid="Q11S.C2.05" des="Max pt curve involving x^3/2; eqn normal" index7="13.5" marks="13 marks" time="16" ttext="Straight lines | Differentiation | Non-integer powers of x | Maxima and minima"></q>
<q index1="|A.H$|D.B.H$|J|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q11S.C2.06" qid="Q11S.C2.06" des="Trap rule; geom trans; simp trig eqn" index7="13.1b | 13.3c | 13.3d | 13.6b" marks="10 marks" time="12" ttext="Transformation of graphs | Trapezium rule | Trigonometry"></q>
<q index1="|I.B$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q11S.C2.07" qid="Q11S.C2.07" des="Simple recurrence involving lim value" index7="13.2a" marks="6 marks" time="7" ttext="Infinite series"></q>
<q index1="|J|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q11S.C2.08" qid="Q11S.C2.08" des="Exp of (a+b)^2; use sin^2 + cos^2 = 1" index7="13.3c | 18.4c | 19" marks="4 marks" time="5" ttext="Trigonometry"></q>
<q index1="|F.E$|H.B$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q11S.C2.09" qid="Q11S.C2.09" des="GP/sum to infinity/nth term; use of logs" index7="13.1a | 13.2c | 13.4a" marks="10 marks" time="12" ttext="Logarithmic function | Geometric series"></q>
<q index1="|D.A.E$|F.E$|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q11S.C3.01" qid="Q11S.C3.01" des="Simple ln exercise; Simpson's rule" index7="14.3b | 14.4a | 14.6c" marks="7 marks" time="8" ttext="Logarithmic functions (differentiation) | Logarithmic function | Numerical methods"></q>
<q index1="|D.A.C$|D.A.D$|D.A.I$|D.A.J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q11S.C3.02" qid="Q11S.C3.02" des="2-part diff; product (expo) and quotient (trig)" index7="14.3b | 14.4a | 14.4b" marks="9 marks" time="11" ttext="Trigonometric functions | Exponential functions (differentiation) | Product | Quotients"></q>
<q index1="|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q11S.C3.03" qid="Q11S.C3.03" des="Std iteration with (simp) inverse trig and expo" index7="14.6a | 14.6b" marks="5 marks" time="6" ttext="Numerical methods"></q>
<q index1="|A.H$|J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q11S.C3.04" qid="Q11S.C3.04" des="Involves cosec and cosec^2=1+cot^2" index7="14.1c | 14.2b | 14.2c" marks="12 marks" time="14" ttext="Transformation of graphs | Trigonometry"></q>
<q index1="|F.A$|F.B$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q11S.C3.05" qid="Q11S.C3.05" des="Std fn qu; inverses/range/composite" index7="14.1a | 14.1c" marks="8 marks" time="10" ttext="Range/domain | Inverse functions"></q>
<q index1="|F.D$|F.E$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q11S.C3.06" qid="Q11S.C3.06" des="Quad eqn in ln x; exact solns reqd" index7="14.3a | 14.3b" marks="6 marks" time="7" ttext="Exponential functions | Logarithmic function"></q>
<q index1="|F.F$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q11S.C3.07" qid="Q11S.C3.07" des="Sketches/eqn/ineq involving mod fns" index7="14.1 | 14.1b" marks="12 marks" time="14" ttext="Modulus function"></q>
<q index1="|D.B.D$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q11S.C3.08" qid="Q11S.C3.08" des="Simple integration using trig subst" index7="14.4a | 14.5b" marks="5 marks" time="6" ttext="Integration by substitution"></q>
<q index1="|D.A.E$|D.B.E$|D.B.G.1$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q11S.C3.09" qid="Q11S.C3.09" des="By parts int/chain rule diff/vol using ln x" index7="14.4a | 14.4b | 14.5b | 14.5c" marks="11 marks" time="13" ttext="Logarithmic functions (differentiation) | Integration by parts | Areas and volumes"></q>
<q index1="|A.A$|A.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q11S.C4.01" qid="Q11S.C4.01" des="Simple use of remainder/factor theorems" index7="15.1a | 15.1b" marks="7 marks" time="8" ttext="Factor theorem | Remainder theorem"></q>
<q index1="|F.D$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q11S.C4.02" qid="Q11S.C4.02" des="Interpretation/manip of expo eqn" index7="15.5" marks="6 marks" time="7" ttext="Exponential functions"></q>
<q index1="|H.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q11S.C4.03" qid="Q11S.C4.03" des="Expansion of (1-x)^n extended to (a-bx)^n" index7="15.3a" marks="7 marks" time="8" ttext="Binomial expansion"></q>
<q index1="|D.A|D.A.H$|D.B|J.A$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q11S.C4.04" qid="Q11S.C4.04" des="2-part; eqn normal(param)/integrate sin^2(x)" index7="15.4b | 15.6 | 15.6c" marks="13 marks" time="16" ttext="Differentiation | Parametric equations | Integration | Double angle"></q>
<q index1="|C.A$|C.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q11S.C4.05" qid="Q11S.C4.05" des="Show lines meet; use sc prod for perp" index7="15.7b | 15.7c" marks="12 marks" time="14" ttext="Equations of lines | Scalar product"></q>
<q index1="|D.A|D.A.G$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q11S.C4.06" qid="Q11S.C4.06" des="Implicit diff involving expo/product/stat pt" index7="15.6c" marks="10 marks" time="12" ttext="Differentiation | Implicit functions"></q>
<q index1="|P.A$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q11S.C4.07" qid="Q11S.C4.07" des="Simple d.e. to be interpreted" index7="15.6a | 15.6b" marks="7 marks" time="8" ttext="Differential equations - 1st order"></q>
<q index1="|D.B.F$|P.A$|P.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q11S.C4.08" qid="Q11S.C4.08" des="PFs (repeated factor); std d.e. involves ln" index7="15.6b | 15.6d" marks="13 marks" time="16" ttext="Integration using partial fractions | Differential equations - 1st order | Variable separable"></q>
<q index1="|K$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q11S.P1.01" qid="Q11S.P1.01" des="Std step-by-step to estimate value" index7="16.6b" marks="5 marks" time="6" ttext="Numerical methods"></q>
<q index1="|A.F$|A.G$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q11S.P1.02" qid="Q11S.P1.02" des="Std;find alpha^2+beta^2 and eqn given roots" index7="16.3" marks="9 marks" time="11" ttext="Roots of quadratic | Roots of polynomials"></q>
<q index1="|L|L.A$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q11S.P1.03" qid="Q11S.P1.03" des="Complex conjugate; mult of complex nos." index7="16.2" marks="7 marks" time="8" ttext="Complex Numbers | Use of x + iy"></q>
<q index1="|F.G$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q11S.P1.04" qid="Q11S.P1.04" des="Connect with linear law graph/estimate values" index7="16.6c" marks="10 marks" time="12" ttext="Reduction to linear law"></q>
<q index1="|J|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q11S.P1.05" qid="Q11S.P1.05" des="Genl soln of cos(3x-a)=b" index7="16.7" marks="7 marks" time="8" ttext="Trigonometry"></q>
<q index1="|B.B$|H.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q11S.P1.06" qid="Q11S.P1.06" des="Find grad adj pts on line; hence grad curve" index7="16.5McLean" marks="7 marks" time="8" ttext="Straight lines | Binomial expansion"></q>
<q index1="|M$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q11S.P1.07" qid="Q11S.P1.07" des="Matrix products and geom transformations" index7="16.8" marks="9 marks" time="11" ttext="Matrices"></q>
<q index1="|A.D$|F.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q11S.P1.08" qid="Q11S.P1.08" des="Rational fn;asymptotes/sketch/assoc ineqn" index7="16.1a | 16.1b" marks="10 marks" time="12" ttext="Inequalities | Rational functions"></q>
<q index1="|A.F$|B.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q11S.P1.09" qid="Q11S.P1.09" des="Parabolas under reflection; common tgt" index7="16.1d" marks="11 marks" time="13" ttext="Roots of quadratic | Conic sections"></q>
<q index1="|L|L.B$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q11S.P2.01" qid="Q11S.P2.01" des="Arg diag loci; arg and mod involved" index7="17.2 | 17.2b" marks="8 marks" time="10" ttext="Complex Numbers | Loci"></q>
<q index1="|G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q11S.P2.02" qid="Q11S.P2.02" des="Expo defns of sinh and cosh to prove various" index7="17.7" marks="10 marks" time="12" ttext="Hyperbolic functions"></q>
<q index1="|I.A$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q11S.P2.03" qid="Q11S.P2.03" des="Diff method for summation; factorials involved" index7="17.5" marks="6 marks" time="7" ttext="Finite series"></q>
<q index1="|A.G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q11S.P2.04" qid="Q11S.P2.04" des="Various symmetric fn work on roots cubic eqn" index7="17.1" marks="14 marks" time="17" ttext="Roots of polynomials"></q>
<q index1="|D.B.D$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q11S.P2.05" qid="Q11S.P2.05" des="CSA integral derivation; eval by hyperb subst" index7="17.8" marks="13 marks" time="16" ttext="Integration by substitution"></q>
<q index1="|E$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q11S.P2.06" qid="Q11S.P2.06" des="Std alg induction (support by prelim alg, if reqd)" index7="17.4" marks="8 marks" time="10" ttext="Proof by induction"></q>
<q index1="|L.C$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q11S.P2.07" qid="Q11S.P2.07" des="Formulae for cos 5x and sin 5x; deductions" index7="17.3a" marks="16 marks" time="19" ttext="De Moivre's Theorem"></q>
<q index1="|K$|P|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q11S.P3.01" qid="Q11S.P3.01" des="Std improved Euler" index7="18.4c" marks="5 marks" time="6" ttext="Numerical methods | Differential equations"></q>
<q index1="|P.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q11S.P3.02" qid="Q11S.P3.02" des="2nd order DE;given PI format;genl/partic soln" index7="18.5 | 18.5a | 18.5b" marks="12 marks" time="14" ttext="Differential Equations - 2nd order"></q>
<q index1="|D.B.E$|I.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q11S.P3.03" qid="Q11S.P3.03" des="Std 'by parts'; associated improper integral" index7="18.1c" marks="7 marks" time="8" ttext="Integration by parts | Improper integrals"></q>
<q index1="|P.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q11S.P3.04" qid="Q11S.P3.04" des="Std integ factor; integral sin x sin 2x reqd" index7="18.4a" marks="10 marks" time="12" ttext="Differential equations - 1st order"></q>
<q index1="|I.E$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q11S.P3.05" qid="Q11S.P3.05" des="ln(1 + 2 tan x) and ln(1 - x) series reqd;also limit" index7="18.1a | 18.1b" marks="10 marks" time="12" ttext="Maclaurin series"></q>
<q index1="|P.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q11S.P3.06" qid="Q11S.P3.06" des="Use given subst to solve 2nd order DE" index7="18.5c" marks="12 marks" time="14" ttext="Differential Equations - 2nd order"></q>
<q index1="|O|O.A$|O.B$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q11S.P3.07" qid="Q11S.P3.07" des="Intersection pts; area contained by 2 arcs" index7="18.2 | 18.2a | 18.2b" marks="19 marks" time="23" ttext="Polar co-ordinates | Cartesian equations | Areas"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q11S.P4.01" qid="Q11S.P4.01" des="Det(3 X 3 matrix); singularity of product" index7="19.2a" marks="6 marks" time="7" ttext="Matrices"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q11S.P4.02" qid="Q11S.P4.02" des="Matrix representing reflection/then rotation" index7="19.2b" marks="6 marks" time="7" ttext="Matrices"></q>
<q index1="|C|C.D$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q11S.P4.03" qid="Q11S.P4.03" des="Std vector prod (2 @ 1 X 3); linear dep" index7="19.1a | 19.5" marks="6 marks" time="7" ttext="Vectors | Vector product"></q>
<q index1="|N.A$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q11S.P4.04" qid="Q11S.P4.04" des="Non-unique soln/infinite no. solns of 3 eqns" index7="19.3" marks="8 marks" time="10" ttext="Evaluate determinants"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q11S.P4.05" qid="Q11S.P4.05" des="Std eigen-value/vector work; 2 X 2 matrices" index7="19.2d" marks="13 marks" time="16" ttext="Matrices"></q>
<q index1="|C|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q11S.P4.06" qid="Q11S.P4.06" des="2-part; effect of matrix transforms on lines " index7="19.2b | 19.2c" marks="13 marks" time="16" ttext="Vectors | Matrices"></q>
<q index1="|N|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q11S.P4.07" qid="Q11S.P4.07" des="Factorise and expand 2 X 2 det" index7="19.4" marks="8 marks" time="10" ttext="Determinants"></q>
<q index1="|C|C.A$|C.B$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q11S.P4.08" qid="Q11S.P4.08" des="Line/plane; angle btwn/pt int; parallel/perp " index7="19.1c" marks="15 marks" time="18" ttext="Vectors | Equations of lines | Equations of planes"></q>
<q index1="|A.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q10W.C1.01" qid="Q10W.C1.01" des="Use of factor theorem to factorise cubic" index7="12.1e" marks="5 marks" time="6" ttext="Factor theorem"></q>
<q index1="|B.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q10W.C1.02" qid="Q10W.C1.02" des="Coord geom; gradient/mid-point/distance" index7="12.2a" marks="12 marks" time="14" ttext="Straight lines"></q>
<q index1="|D.A|D.A.A$|D.A.J.1$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q10W.C1.03" qid="Q10W.C1.03" des="Max/min; rate of change; inc/dec function" index7="12.3a | 12.3b" marks="12 marks" time="14" ttext="Differentiation | Polynomials | Maxima and minima"></q>
<q index1="|A.I$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q10W.C1.04" qid="Q10W.C1.04" des="Std surd prob including rationalising denom" index7="12.1a" marks="7 marks" time="8" ttext="Surds/indices"></q>
<q index1="|A.C$|A.H$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q10W.C1.05" qid="Q10W.C1.05" des="Complete square;assoc graph;geom transform" index7="12.1b | 12.1f" marks="11 marks" time="13" ttext="Completing the square | Transformation of graphs"></q>
<q index1="|D.A|D.A.A$|D.B|D.B.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q10W.C1.06" qid="Q10W.C1.06" des="Eqn normal to cubic; area btwn cubic and line" index7="12.3a | 12.3b | 12.4a | 12.4b" marks="15 marks" time="18" ttext="Differentiation | Polynomials | Integration | Integration of polynomials"></q>
<q index1="|A.D$|B.A$|B.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q10W.C1.07" qid="Q10W.C1.07" des="Centre/rad circle; line length; soln quad ineq" index7="12.1d | 12.2a | 12.2b" marks="13 marks" time="16" ttext="Inequalities | Circle | Straight lines"></q>
<q index1="|J|J.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q10W.C2.01" qid="Q10W.C2.01" des="Std sector area/arc length; also cosine rule" index7="13.3a | 13.3b" marks="9 marks" time="11" ttext="Trigonometry | Arc length/area of sectors/segments"></q>
<q index1="|A.I$|D.B.B$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q10W.C2.02" qid="Q10W.C2.02" des="Given grad and pt/find eqn curve" index7="13.1a | 13.6a" marks="7 marks" time="8" ttext="Surds/indices | Integration of non-integer powers of x"></q>
<q index1="|F.D$|F.E$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q10W.C2.03" qid="Q10W.C2.03" des="2-part:Solve log x = a; use log c+log d = log cd " index7="13.4 | 13.4a" marks="7 marks" time="8" ttext="Exponential functions | Logarithmic function"></q>
<q index1="|H.A$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q10W.C2.04" qid="Q10W.C2.04" des="AP term and sum formulae; sigma notation" index7="13.2b" marks="10 marks" time="12" ttext="Arithmetic series"></q>
<q index1="|B.B$|D.A|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q10W.C2.05" qid="Q10W.C2.05" des="Diff involving x^-3 to find eqns tgt/normal" index7="13.6" marks="10 marks" time="12" ttext="Straight lines | Differentiation"></q>
<q index1="|A.H$|D.B|F.D$|F.E$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q10W.C2.06" qid="Q10W.C2.06" des="Trap rule; geom transform; log/index equiv" index7="13.4b | 13.6b" marks="12 marks" time="14" ttext="Transformation of graphs | Integration | Exponential functions | Logarithmic function"></q>
<q index1="|H.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q10W.C2.07" qid="Q10W.C2.07" des="Std exp of (1+ax)^n; coeff from prod 2 exps" index7="13.2d" marks="8 marks" time="10" ttext="Binomial expansion"></q>
<q index1="|J|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q10W.C2.08" qid="Q10W.C2.08" des="Solve tan(x+a)=tan b/Pythag to prod quad eqn" index7="13.3c | 13.3d" marks="12 marks" time="14" ttext="Trigonometry"></q>
<q index1="|D.A.D$|D.A.I$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q10W.C3.01" qid="Q10W.C3.01" des="Stationary values of product involving exp(-4x)" index7="14.4a | 14.4b" marks="8 marks" time="10" ttext="Exponential functions (differentiation) | Product"></q>
<q index1="|J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q10W.C3.02" qid="Q10W.C3.02" des="Inv sin fn; mainly iter qu (incl cobweb/staircase)" index7="14.2a | 14.6a | 14.6b" marks="11 marks" time="13" ttext="Trigonometry"></q>
<q index1="|J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q10W.C3.03" qid="Q10W.C3.03" des="2 trig eqns using cosec and cosec^2=1+cot^2" index7="14.2b | 14.2c" marks="8 marks" time="10" ttext="Trigonometry"></q>
<q index1="|F.F$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q10W.C3.04" qid="Q10W.C3.04" des="Graph/equation/inequality based on mod fn" index7="14.1 | 14.1b" marks="6 marks" time="7" ttext="Modulus function"></q>
<q index1="|A.H$|D.B|D.B.C$|F.D$|F.E$|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q10W.C3.05" qid="Q10W.C3.05" des=" Mid-ord rule/vol abt y-axis/transformations" index7="14.1c | 14.3 | 14.5a | 14.5c | 14.6c" marks="12 marks" time="14" ttext="Transformation of graphs | Integration | Integration of exponential functions | Exponential functions | Logarithmic function | Numerical methods"></q>
<q index1="|F.A$|F.B$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q10W.C3.06" qid="Q10W.C3.06" des="Fn qu (involves e^2x); range/inverse/comp fn" index7="14.1 | 14.1a" marks="11 marks" time="13" ttext="Range/domain | Inverse functions"></q>
<q index1="|D.A|D.A.C$|J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q10W.C3.07" qid="Q10W.C3.07" des="Diff sin4x/cos4x; use of chain rule (stretching) " index7="14.2c | 14.4a | 14.4b" marks="8 marks" time="10" ttext="Differentiation | Trigonometric functions | Trigonometry"></q>
<q index1="|D.B.D$|D.B.E$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q10W.C3.08" qid="Q10W.C3.08" des="2-part; int by parts; std int by subst" index7="14.5a | 14.5b" marks="11 marks" time="13" ttext="Integration by substitution | Integration by parts"></q>
<q index1="|A.A$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q10W.C4.01" qid="Q10W.C4.01" des="Use factor theorem to simplify rational exp" index7="15.1a | 15.1b" marks="8 marks" time="10" ttext="Factor theorem"></q>
<q index1="|J|J.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q10W.C4.02" qid="Q10W.C4.02" des="Use Rcos(x-a) to find min value/solve eqn" index7="15.4a" marks="10 marks" time="12" ttext="Trigonometry | Sum or diff of 2 angles"></q>
<q index1="|H.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q10W.C4.03" qid="Q10W.C4.03" des="(1+x)^n leading to (1+ax)^n; awkward deduct" index7="15.3a" marks="7 marks" time="8" ttext="Binomial expansion"></q>
<q index1="|D.B.F$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q10W.C4.04" qid="Q10W.C4.04" des="Partial fractions leading to indefinite integral" index7="15.1c | 15.1d | 15.6d" marks="8 marks" time="10" ttext="Integration using partial fractions"></q>
<q index1="|D.A|D.A.D$|D.A.G$|D.A.I$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q10W.C4.05" qid="Q10W.C4.05" des="Find gradient at pt on curve defined implicitly" index7="15.5 | 15.6c" marks="5 marks" time="6" ttext="Differentiation | Exponential functions (differentiation) | Implicit functions | Product"></q>
<q index1="|D.A|D.A.C$|D.A.H$|J|J.A$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q10W.C4.06" qid="Q10W.C4.06" des="Double angle formulae in param diff and trig" index7="15.4b | 15.6c" marks="10 marks" time="12" ttext="Differentiation | Trigonometric functions | Parametric equations | Trigonometry | Double angle"></q>
<q index1="|P|P.A$|P.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q10W.C4.07" qid="Q10W.C4.07" des="Simple d.e. involving integration of cos(x/3)" index7="15.6b" marks="6 marks" time="7" ttext="Differential equations | Differential equations - 1st order | Variable separable"></q>
<q index1="|B.B$|C|C.A$|C.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q10W.C4.08" qid="Q10W.C4.08" des="Basic vector principles incl perpendicularity" index7="15.7 | 15.7a | 15.7c" marks="11 marks" time="13" ttext="Straight lines | Vectors | Equations of lines | Scalar product"></q>
<q index1="|A.A$|A.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q10W.C4.09" qid="Q10W.C4.09" des="Use remainder/factor thms to factorise cubic" index7="15.1a" marks="10 marks" time="12" ttext="Factor theorem | Remainder theorem"></q>
<q index1="|A.F$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q10W.P1.01" qid="Q10W.P1.01" des="Manipulation exps; find eqn with given roots" index7="16.3" marks="9 marks" time="11" ttext="Roots of quadratic"></q>
<q index1="|L|L.A$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q10W.P1.02" qid="Q10W.P1.02" des="Squaring complex no. and its conj/using i^4=1" index7="16.2" marks="6 marks" time="7" ttext="Complex Numbers | Use of x + iy"></q>
<q index1="|J|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q10W.P1.03" qid="Q10W.P1.03" des="General soln of sin(4x+a) = 1" index7="16.7" marks="4 marks" time="5" ttext="Trigonometry"></q>
<q index1="|M$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q10W.P1.04" qid="Q10W.P1.04" des="Matrices; Identity/subtraction/squaring" index7="16.8" marks="7 marks" time="8" ttext="Matrices"></q>
<q index1="|D.B|D.B.B$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q10W.P1.05" qid="Q10W.P1.05" des="Improper integrals; value or non-value?" index7="16.5b" marks="7 marks" time="8" ttext="Integration | Integration of non-integer powers of x"></q>
<q index1="|M$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q10W.P1.06" qid="Q10W.P1.06" des="Matrix mappings of rectangle/includes rotation" index7="16.8" marks="8 marks" time="10" ttext="Matrices"></q>
<q index1="|F.C$|K$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q10W.P1.07" qid="Q10W.P1.07" des="Asymptotes/sketch rational fn; use int bisection" index7="16.1a | 16.6 | 16.6a" marks="9 marks" time="11" ttext="Rational functions | Numerical methods"></q>
<q index1="|I.A$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q10W.P1.08" qid="Q10W.P1.08" des="Use sigma(r, r^2, r^3); alg factor manip needed" index7="16.4" marks="9 marks" time="11" ttext="Finite series"></q>
<q index1="|A.F$|B.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q10W.P1.09" qid="Q10W.P1.09" des="Hyperbola;asym eqns/int with line/equal roots" index7="16.1d" marks="16 marks" time="19" ttext="Roots of quadratic | Conic sections"></q>
<q index1="|G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q10W.P2.01" qid="Q10W.P2.01" des="Std hyperbolic formulae incl logs inverse fns" index7="17.7" marks="9 marks" time="11" ttext="Hyperbolic functions"></q>
<q index1="|L|L.B$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q10W.P2.02" qid="Q10W.P2.02" des="Simple loci rep circle/line; interpret inequalities" index7="17.2 | 17.2b" marks="8 marks" time="10" ttext="Complex Numbers | Loci"></q>
<q index1="|A.G$|L|L.A$|L.C$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q10W.P2.03" qid="Q10W.P2.03" des="Conj pr roots cubic; find 3rd; de Moivre manip" index7="17.2 | 17.2a | 17.3a" marks="14 marks" time="17" ttext="Roots of polynomials | Complex Numbers | Use of x + iy | De Moivre's Theorem"></q>
<q index1="|D.B|D.C$|G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q10W.P2.04" qid="Q10W.P2.04" des="Params/surface area (integral by inspect)" index7="17.7 | 17.8" marks="10 marks" time="12" ttext="Integration | Arc Length and Area of Surf. Revol | Hyperbolic functions"></q>
<q index1="|I.A$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q10W.P2.05" qid="Q10W.P2.05" des="Use u(n) = S(n) - S(n-1); find sigma (n+1 to 2n)" index7="17.5" marks="8 marks" time="10" ttext="Finite series"></q>
<q index1="|D.B.D$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q10W.P2.06" qid="Q10W.P2.06" des="Use t = tan(theta); reduce to int of 1/(a^2+t^2)" index7="17.6" marks="6 marks" time="7" ttext="Integration by substitution"></q>
<q index1="|E$|I.A$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q10W.P2.07" qid="Q10W.P2.07" des="Induction applied to seq; GP sum poss useful" index7="17.4 | 17.5" marks="8 marks" time="10" ttext="Proof by induction | Finite series"></q>
<q index1="|A.G$|J|L|L.C$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q10W.P2.08" qid="Q10W.P2.08" des="Various de Moivre; roots of poly; cos A + cos B" index7="17.3a" marks="12 marks" time="14" ttext="Roots of polynomials | Trigonometry | Complex Numbers | De Moivre's Theorem"></q>
<q index1="|K$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q10W.P3.01" qid="Q10W.P3.01" des="Use Euler's formulae to obtain approximations" index7="18.4c" marks="8 marks" time="10" ttext="Numerical methods"></q>
<q index1="|I|I.E$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q10W.P3.02" qid="Q10W.P3.02" des="Find Macl exp for ln(4+3x); deduce ln(4-3x)" index7="18.1a" marks="8 marks" time="10" ttext="Series and limits | Maclaurin series"></q>
<q index1="|P.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q10W.P3.03" qid="Q10W.P3.03" des="2nd order DE; subst leads to 1st order" index7="18.5c" marks="9 marks" time="11" ttext="Differential Equations - 2nd order"></q>
<q index1="|I|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q10W.P3.04" qid="Q10W.P3.04" des="Use trig expansions to find limit of expression" index7="18.1b | 18.1d" marks="5 marks" time="6" ttext="Series and limits"></q>
<q index1="|P.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q10W.P3.05" qid="Q10W.P3.05" des="Soln 2nd order DE/ format of P.I. is given" index7="18.5 | 18.5b" marks="12 marks" time="14" ttext="Differential Equations - 2nd order"></q>
<q index1="|D.B.E$|I.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q10W.P3.06" qid="Q10W.P3.06" des="Explain imp int; subst to transform/find value" index7="18.1c" marks="9 marks" time="11" ttext="Integration by parts | Improper integrals"></q>
<q index1="|P.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q10W.P3.07" qid="Q10W.P3.07" des="2nd order DE; complex roots aux eqn" index7="18.5 | 18.5a | 18.5b" marks="8 marks" time="10" ttext="Differential Equations - 2nd order"></q>
<q index1="|O|O.B$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q10W.P3.08" qid="Q10W.P3.08" des="Polar wk; int curve/line; area betwn curve/line" index7="18.2 | 18.2a | 18.2b" marks="16 marks" time="19" ttext="Polar co-ordinates | Areas"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q10W.P4.01" qid="Q10W.P4.01" des="Rotate/reflect/shear/enlarge in 2 D " index7="19.2b" marks="4 marks" time="5" ttext="Matrices"></q>
<q index1="|C|C.C$|C.D$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q10W.P4.02" qid="Q10W.P4.02" des="P'piped; area of face/volume/dist betw 2 faces " index7="19.1 | 19.1a | 19.1b | 19.1c" marks="8 marks" time="10" ttext="Vectors | Scalar product | Vector product"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q10W.P4.03" qid="Q10W.P4.03" des="3 X 3 matrices; multiplic/identity/inverse" index7="19.2a" marks="7 marks" time="8" ttext="Matrices"></q>
<q index1="|N|N.B$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q10W.P4.04" qid="Q10W.P4.04" des="3 eqns; non-unique solns; consistent/inconsist" index7="19.3 | 19.4" marks="12 marks" time="14" ttext="Determinants | Use and solving equations"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q10W.P4.05" qid="Q10W.P4.05" des="2 X 2 transf;image line/area effect/composition" index7="19.2 | 19.2b" marks="10 marks" time="12" ttext="Matrices"></q>
<q index1="|C|C.B$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q10W.P4.06" qid="Q10W.P4.06" des="Perp/p'llel planes;cartesian/plane intersectns" index7="19.1 | 19.1c | 19.1d" marks="16 marks" time="19" ttext="Vectors | Equations of planes"></q>
<q index1="|M$|N|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q10W.P4.07" qid="Q10W.P4.07" des="Factors det; e-vectors/values; invariant lines" index7="19.2a | 19.2c | 19.2d | 19.4" marks="18 marks" time="22" ttext="Matrices | Determinants"></q>
<q index1="|B|B.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q10S.C1.01" qid="Q10S.C1.01" des="Grad line; eqns parallel/perp; line intersections" index7="12.2a" marks="11 marks" time="13" ttext="Co-ordinate geometry | Straight lines"></q>
<q index1="|A.I$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q10S.C1.02" qid="Q10S.C1.02" des="Surd manip incl (a - b)^2; rationalising denom" index7="12.1a" marks="6 marks" time="7" ttext="Surds/indices"></q>
<q index1="|A.A$|A.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q10S.C1.03" qid="Q10S.C1.03" des="Factorisation of cubic; sketch assoc curve" index7="12.1e | 12.1f" marks="12 marks" time="14" ttext="Factor theorem | Remainder theorem"></q>
<q index1="|D.A|D.A.A$|D.B|D.B.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q10S.C1.04" qid="Q10S.C1.04" des="Area between cubic/line; eqn tgt to curve" index7="12.3a | 12.3b | 12.4a | 12.4b" marks="12 marks" time="14" ttext="Differentiation | Polynomials | Integration | Integration of polynomials"></q>
<q index1="|B.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q10S.C1.05" qid="Q10S.C1.05" des="Given centre/rad; find circle eqn; eqn normal" index7="12.2b | 12.2c" marks="11 marks" time="13" ttext="Circle"></q>
<q index1="|D.A|D.A.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q10S.C1.06" qid="Q10S.C1.06" des="Block of wood; (standard) max/min problem" index7="12.3a | 12.3b | 12.3c" marks="11 marks" time="13" ttext="Differentiation | Polynomials"></q>
<q index1="|A.C$|A.D$|A.F$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q10S.C1.07" qid="Q10S.C1.07" des="Real roots 2 diff quadratics; comp sq/discrim" index7="12.1b | 12.1d" marks="12 marks" time="14" ttext="Completing the square | Inequalities | Roots of quadratic"></q>
<q index1="|J.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q10S.C2.01" qid="Q10S.C2.01" des="Given incl angle/sector radius; find area/perim" index7="13.3b" marks="7 marks" time="8" ttext="Arc length/area of sectors/segments"></q>
<q index1="|H|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q10S.C2.02" qid="Q10S.C2.02" des="Simple recurrence; find spec terms/seq limit" index7="13.2a" marks="5 marks" time="6" ttext="Sequences and series"></q>
<q index1="|J|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q10S.C2.03" qid="Q10S.C2.03" des="Std sine rule and triangle area" index7="13.3a" marks="6 marks" time="7" ttext="Trigonometry"></q>
<q index1="|D.B|H.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q10S.C2.04" qid="Q10S.C2.04" des="Cubic binom expansion/def integral of same" index7="13.2d | 13.6" marks="8 marks" time="10" ttext="Integration | Binomial expansion"></q>
<q index1="|A.E$|H.A$|H.B$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q10S.C2.05" qid="Q10S.C2.05" des="Structured qun testing std features GP/AP" index7="13.2b | 13.2c" marks="11 marks" time="13" ttext="Simultaneous equations | Arithmetic series | Geometric series"></q>
<q index1="|A.I$|B.B$|D.A|D.A.B$|D.A.J.1$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q10S.C2.06" qid="Q10S.C2.06" des="y = x^n+x^-1/m; eqn normal/show no max pts" index7="13.1a | 13.5" marks="13 marks" time="16" ttext="Surds/indices | Straight lines | Differentiation | Non-integer powers of x | Maxima and minima"></q>
<q index1="|J|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q10S.C2.07" qid="Q10S.C2.07" des="cos graph; pythag rel/subst; cos 2x=0.5" index7="13.3c | 13.3d" marks="8 marks" time="10" ttext="Trigonometry"></q>
<q index1="|A.H$|A.I$|D.B|F.D$|F.E$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q10S.C2.08" qid="Q10S.C2.08" des="Long; trap rule/geom transforms/soln a^x=b" index7="13.1a | 13.1b | 13.4a | 13.4b | 13.6b" marks="17 marks" time="20" ttext="Transformation of graphs | Surds/indices | Integration | Exponential functions | Logarithmic function"></q>
<q index1="|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q10S.C3.01" qid="Q10S.C3.01" des="Iterative process involves location/manip" index7="14.6a | 14.6b" marks="5 marks" time="6" ttext="Numerical methods"></q>
<q index1="|A.H$|F.F$|J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q10S.C3.02" qid="Q10S.C3.02" des="Sec x; tests modulus/solves 2 assoc eqns" index7="14.1b | 14.1c | 14.2b" marks="10 marks" time="12" ttext="Transformation of graphs | Modulus function | Trigonometry"></q>
<q index1="|D.A|D.A.C$|D.A.E$|F|F.A$|F.B$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q10S.C3.03" qid="Q10S.C3.03" des="2-part; ln/trig derivs; ln/trig fns/comp/inv" index7="14.1a | 14.2a | 14.4a" marks="12 marks" time="14" ttext="Differentiation | Trigonometric functions | Logarithmic functions (differentiation) | Functions | Range/domain | Inverse functions"></q>
<q index1="|D.B|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q10S.C3.04" qid="Q10S.C3.04" des="2-part; std Simpson's rule; def integral f '/f" index7="14.5a | 14.6 | 14.6c" marks="8 marks" time="10" ttext="Integration | Numerical methods"></q>
<q index1="|J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q10S.C3.05" qid="Q10S.C3.05" des="cosec^2 = 1+cot^2 to prod/solve quad(cot x)" index7="14.2b | 14.2c" marks="5 marks" time="6" ttext="Trigonometry"></q>
<q index1="|D.A|D.A.E$|D.A.J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q10S.C3.06" qid="Q10S.C3.06" des="y=ln x/x; find stat pt/grad normal at specific pt" index7="14.4a | 14.4b" marks="9 marks" time="11" ttext="Differentiation | Logarithmic functions (differentiation) | Quotients"></q>
<q index1="|D.B.E$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q10S.C3.07" qid="Q10S.C3.07" des="3 connected items involving int by parts" index7="14.5a | 14.5b | 14.5c" marks="11 marks" time="13" ttext="Integration by parts"></q>
<q index1="|A.F$|A.H$|D.B|D.B.C$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q10S.C3.08" qid="Q10S.C3.08" des="Geom trans/quad exp(2x)/area btwn 2 curves" index7="14.1c | 14.3a | 14.5a" marks="15 marks" time="18" ttext="Roots of quadratic | Transformation of graphs | Integration | Integration of exponential functions"></q>
<q index1="|A.A$|A.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q10S.C4.01" qid="Q10S.C4.01" des="Remainder/factor theorems to factorise cubic" index7="15.1a" marks="7 marks" time="8" ttext="Factor theorem | Remainder theorem"></q>
<q index1="|B.B$|D.A|D.A.H$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q10S.C4.02" qid="Q10S.C4.02" des="Given param eqns;find eqn normal/cartes eqn" index7="15.2 | 15.6c" marks="9 marks" time="11" ttext="Straight lines | Differentiation | Parametric equations"></q>
<q index1="|D.B.F$|F.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q10S.C4.03" qid="Q10S.C4.03" des="PFs to integrate rational fn/algebraic division" index7="15.1c | 15.1d | 15.6d" marks="8 marks" time="10" ttext="Integration using partial fractions | Rational functions"></q>
<q index1="|H.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q10S.C4.04" qid="Q10S.C4.04" des="(1+x)^n extending to (16+9x)^n; num approx" index7="15.3a" marks="7 marks" time="8" ttext="Binomial expansion"></q>
<q index1="|J.A$|J.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q10S.C4.05" qid="Q10S.C4.05" des="Use cos 2x and Rcos(x-a) to solve assoc eqns" index7="15.4a | 15.4b" marks="11 marks" time="13" ttext="Double angle | Sum or diff of 2 angles"></q>
<q index1="|D.A|D.A.C$|D.A.G$|D.A.I$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q10S.C4.06" qid="Q10S.C4.06" des="Impl eqn; find grad/solve eqn involving cos(pi)" index7="15.6c" marks="7 marks" time="8" ttext="Differentiation | Trigonometric functions | Implicit functions | Product"></q>
<q index1="|C|C.A$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q10S.C4.07" qid="Q10S.C4.07" des="Intersection of 2 lines; problem re parallel lines" index7="15.7 | 15.7a | 15.7b" marks="12 marks" time="14" ttext="Vectors | Equations of lines"></q>
<q index1="|D.B.B$|P|P.A$|P.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q10S.C4.08" qid="Q10S.C4.08" des="Simple DE/assoc pract prob; form DE/interpr" index7="15.6a | 15.6b" marks="14 marks" time="17" ttext="Integration of non-integer powers of x | Differential equations | Differential equations - 1st order | Variable separable"></q>
<q index1="|K$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q10S.P1.01" qid="Q10S.P1.01" des="Standard step-by-step example" index7="16.6 | 16.6b" marks="6 marks" time="7" ttext="Numerical methods"></q>
<q index1="|L|L.A$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q10S.P1.02" qid="Q10S.P1.02" des="Complex nos; mult/conjugate/real/imag" index7="16.2" marks="6 marks" time="7" ttext="Complex Numbers | Use of x + iy"></q>
<q index1="|J|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q10S.P1.03" qid="Q10S.P1.03" des="General soln of cos(5x - a) = cos b" index7="16.7" marks="5 marks" time="6" ttext="Trigonometry"></q>
<q index1="|K$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q10S.P1.04" qid="Q10S.P1.04" des="Linear law;graph to est values unknown consts" index7="16.6 | 16.6c" marks="8 marks" time="10" ttext="Numerical methods"></q>
<q index1="|B.B$|D.A|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q10S.P1.05" qid="Q10S.P1.05" des="Grad line joining adjacent pts on curve/Limit" index7="16.5 | 16.5McLean" marks="6 marks" time="7" ttext="Straight lines | Differentiation"></q>
<q index1="|M$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q10S.P1.06" qid="Q10S.P1.06" des="Describe transforms rep by various matrices" index7="16.8" marks="11 marks" time="13" ttext="Matrices"></q>
<q index1="|F.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q10S.P1.07" qid="Q10S.P1.07" des="Find asym/int with axes/line; quad eqn/ineqn" index7="16.1 | 16.1a | 16.1b" marks="10 marks" time="12" ttext="Rational functions"></q>
<q index1="|A.F$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q10S.P1.08" qid="Q10S.P1.08" des="Std manip roots quad eqn;form eqn w new roots" index7="16.3" marks="10 marks" time="12" ttext="Roots of quadratic"></q>
<q index1="|A.E$|B.B$|B.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q10S.P1.09" qid="Q10S.P1.09" des="Int of line/parabola; equal roots; tangency" index7="16.1 | 16.1d" marks="13 marks" time="16" ttext="Simultaneous equations | Straight lines | Conic sections"></q>
<q index1="|F.D$|G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q10S.P2.01" qid="Q10S.P2.01" des="sinh and cosh expo formulae; soln quad exp(x)" index7="17.7" marks="9 marks" time="11" ttext="Exponential functions | Hyperbolic functions"></q>
<q index1="|I.A$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q10S.P2.02" qid="Q10S.P2.02" des="Simple PFs; then method of differences" index7="17.5" marks="8 marks" time="10" ttext="Finite series"></q>
<q index1="|L|L.B$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q10S.P2.03" qid="Q10S.P2.03" des="Arg diag loci; line bisector/arg; assoc ineqns" index7="17.2 | 17.2b" marks="9 marks" time="11" ttext="Complex Numbers | Loci"></q>
<q index1="|A.G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q10S.P2.04" qid="Q10S.P2.04" des="Manip roots/cfs poly eqn; soln cubic " index7="17.1" marks="13 marks" time="16" ttext="Roots of polynomials"></q>
<q index1="|D.A|D.C$|G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q10S.P2.05" qid="Q10S.P2.05" des="Hyperbol forms (incl differentiation); arc length" index7="17.7 | 17.8" marks="18 marks" time="22" ttext="Differentiation | Arc Length and Area of Surf. Revol | Hyperbolic functions"></q>
<q index1="|E$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q10S.P2.06" qid="Q10S.P2.06" des="Factorial simplification; std proof by induction " index7="17.4" marks="8 marks" time="10" ttext="Proof by induction"></q>
<q index1="|L|L.C$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q10S.P2.07" qid="Q10S.P2.07" des="Expo form of complex number; powers/roots" index7="17.3 | 17.3a | 17.3b | 17.3c" marks="10 marks" time="12" ttext="Complex Numbers | De Moivre's Theorem"></q>
<q index1="|K$|P.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q10S.P3.01" qid="Q10S.P3.01" des="Use Euler formulae to obtain approximations" index7="18.4 | 18.4c" marks="6 marks" time="7" ttext="Numerical methods | Differential equations - 1st order"></q>
<q index1="|P.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q10S.P3.02" qid="Q10S.P3.02" des="2nd order DE; AE complex rts; PI format given" index7="18.5 | 18.5a | 18.5b" marks="7 marks" time="8" ttext="Differential Equations - 2nd order"></q>
<q index1="|D.B.E$|I.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q10S.P3.03" qid="Q10S.P3.03" des="State why improper int/evaluation incl 'by parts'" index7="18.1b | 18.1c" marks="7 marks" time="8" ttext="Integration by parts | Improper integrals"></q>
<q index1="|P.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q10S.P3.04" qid="Q10S.P3.04" des="1st order DE; involves integral x^3.f(x^4)" index7="18.4a" marks="9 marks" time="11" ttext="Differential equations - 1st order"></q>
<q index1="|I.E$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q10S.P3.05" qid="Q10S.P3.05" des="Involves trig exp/ Maclaurin/lim rational fn" index7="18.1a | 18.1b | 18.1d" marks="13 marks" time="16" ttext="Maclaurin series"></q>
<q index1="|O|O.A$|O.B$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q10S.P3.06" qid="Q10S.P3.06" des="Polar; find cart eqn; area; int of 2 polar curves " index7="18.2 | 18.2a | 18.2b" marks="19 marks" time="23" ttext="Polar co-ordinates | Cartesian equations | Areas"></q>
<q index1="|P.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q10S.P3.07" qid="Q10S.P3.07" des="Use subst to reduce to std 2nd order DE" index7="18.5 | 18.5a | 18.5b" marks="14 marks" time="17" ttext="Differential Equations - 2nd order"></q>
<q index1="|C|C.D$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q10S.P4.01" qid="Q10S.P4.01" des="Show 3 vectors lin dep; determine area triangle" index7="19.1 | 19.1a | 19.5" marks="6 marks" time="7" ttext="Vectors | Vector product"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q10S.P4.02" qid="Q10S.P4.02" des="2X2 matrices; multiplication and transpose" index7="19.2a" marks="7 marks" time="8" ttext="Matrices"></q>
<q index1="|C|C.B$|C.C$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q10S.P4.03" qid="Q10S.P4.03" des="Eqn plane; cos(angle betw 2 planes)" index7="19.1 | 19.1c" marks="7 marks" time="6" ttext="Vectors | Equations of planes | Scalar product"></q>
<q index1="|C|C.A$|C.D$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q10S.P4.04" qid="Q10S.P4.04" des="Eqn line (r-u) X v = 0; find vect pr and sc tr pr" index7="19.1 | 19.1a | 19.1b | 19.1c" marks="10 marks" time="12" ttext="Vectors | Equations of lines | Vector product"></q>
<q index1="|N|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q10S.P4.05" qid="Q10S.P4.05" des="Factorise 3X3 determinant" index7="19.4" marks="8 marks" time="10" ttext="Determinants"></q>
<q index1="|C|C.A$|C.B$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q10S.P4.06" qid="Q10S.P4.06" des="Line dir cos; show line perp plane; solve 3 eqns" index7="19.1 | 19.1c | 19.3" marks="14 marks" time="17" ttext="Vectors | Equations of lines | Equations of planes"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q10S.P4.07" qid="Q10S.P4.07" des="Eigenvalues/vectors of 2X2 matrix diag form" index7="19.2a | 19.2d" marks="16 marks" time="19" ttext="Matrices"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q10S.P4.08" qid="Q10S.P4.08" des="2X2 matrix transformations; enlargement/shear" index7="19.2b" marks="7 marks" time="8" ttext="Matrices"></q>
<q index1="|B.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q09W.C1.01" qid="Q09W.C1.01" des="Includes mid-point/gradient/perp line" index7="12.2a" marks="9 marks" time="11" ttext="Straight lines"></q>
<q index1="|A.D$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q09W.C1.02" qid="Q09W.C1.02" des="Basic quadratic inequality" index7="12.1d" marks="4 marks" time="5" ttext="Inequalities"></q>
<q index1="|A.I$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q09W.C1.03" qid="Q09W.C1.03" des="Rationalisation of denomin/products of surds" index7="12.1a" marks="7 marks" time="8" ttext="Surds/indices"></q>
<q index1="|A.C$|A.H$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q09W.C1.04" qid="Q09W.C1.04" des="Completing square/min value/geom transform" index7="12.1b | 12.1f" marks="10 marks" time="12" ttext="Completing the square | Transformation of graphs"></q>
<q index1="|D.A|D.A.A$|D.A.J.1$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q09W.C1.05" qid="Q09W.C1.05" des="Max/min/rate of change and inc/dec fn" index7="12.3a | 12.3b | 12.3c" marks="13 marks" time="16" ttext="Differentiation | Polynomials | Maxima and minima"></q>
<q index1="|A.A$|B.B$|D.A|D.A.A$|D.B|D.B.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q09W.C1.06" qid="Q09W.C1.06" des="Factor theorem and diff/ eqn tgt / int / area" index7="12.1e | 12.2c | 12.3a | 12.4a | 12.4b" marks="15 marks" time="18" ttext="Factor theorem | Straight lines | Differentiation | Polynomials | Integration | Integration of polynomials"></q>
<q index1="|A.C$|A.F$|B.A$|B.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q09W.C1.07" qid="Q09W.C1.07" des="Circle/centre/rad/normal ; intersect line/circle" index7="12.1b | 12.1c | 12.2a | 12.2b | 12.2d" marks="17 marks" time="20" ttext="Completing the square | Roots of quadratic | Circle | Straight lines"></q>
<q index1="|J.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q09W.C2.01" qid="Q09W.C2.01" des="Standard sector area and perimeter" index7="13.3b" marks="7 marks" time="8" ttext="Arc length/area of sectors/segments"></q>
<q index1="|D.B|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q09W.C2.02" qid="Q09W.C2.02" des="Std trap rule including possible improvement" index7="13.6b" marks="5 marks" time="6" ttext="Integration"></q>
<q index1="|J|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q09W.C2.03" qid="Q09W.C2.03" des="Simple use of sine/cosine rules; area triangle" index7="13.3a" marks="7 marks" time="8" ttext="Trigonometry"></q>
<q index1="|A.H$|B.B$|D.A|D.A.I$|D.B|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q09W.C2.04" qid="Q09W.C2.04" des="Eqn normal;area btwn 2 curves;non-int powers" index7="13.1b | 13.5 | 13.6a" marks="14 marks" time="17" ttext="Transformation of graphs | Straight lines | Differentiation | Product | Integration"></q>
<q index1="|D.A|D.A.A$|D.A.J.1$|H.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q09W.C2.05" qid="Q09W.C2.05" des="Simple quartic expansion; also stationary point" index7="13.2d" marks="11 marks" time="13" ttext="Differentiation | Polynomials | Maxima and minima | Binomial expansion"></q>
<q index1="|F.D$|F.E$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q09W.C2.06" qid="Q09W.C2.06" des="Log laws; soln of a^x=b; logs to powers" index7="13.1a | 13.4a | 13.4b" marks="9 marks" time="11" ttext="Exponential functions | Logarithmic function"></q>
<q index1="|J|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q09W.C2.07" qid="Q09W.C2.07" des="Soln sin x = a; periodicity of sin graph" index7="13.3c | 13.3d" marks="13 marks" time="16" ttext="Trigonometry"></q>
<q index1="|A.E$|H.A$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q09W.C2.08" qid="Q09W.C2.08" des="nth term and S(n) produce simultaneous eqns" index7="13.2b" marks="9 marks" time="11" ttext="Simultaneous equations | Arithmetic series"></q>
<q index1="|D.B|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q09W.C3.01" qid="Q09W.C3.01" des="Std Simpson's rule" index7="14.6c" marks="4 marks" time="5" ttext="Integration | Numerical methods"></q>
<q index1="|D.B|D.B.A$|D.B.G.1$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q09W.C3.02" qid="Q09W.C3.02" des="Std volume involving integral of (x - 2)^5" index7="14.5c" marks="4 marks" time="5" ttext="Integration | Integration of polynomials | Areas and volumes"></q>
<q index1="|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q09W.C3.03" qid="Q09W.C3.03" des="Std iteration; also involves cobweb/staircase" index7="14.6 | 14.6a | 14.6b" marks="7 marks" time="8" ttext="Numerical methods"></q>
<q index1="|J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q09W.C3.04" qid="Q09W.C3.04" des="Knowledge reqd of sec x and sec^2 = 1+tan^2" index7="14.2b | 14.2c" marks="8 marks" time="10" ttext="Trigonometry"></q>
<q index1="|F.A$|F.B$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q09W.C3.05" qid="Q09W.C3.05" des="Range/reason no inverse/composite fn eqn" index7="14.1a" marks="7 marks" time="8" ttext="Range/domain | Inverse functions"></q>
<q index1="|D.A|D.A.A$|D.A.D$|D.A.I$|D.A.J.1$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q09W.C3.06" qid="Q09W.C3.06" des="Nature of stat pts/involving product and e^2x" index7="14.4a | 14.4b" marks="10 marks" time="12" ttext="Differentiation | Polynomials | Exponential functions (differentiation) | Product | Maxima and minima"></q>
<q index1="|A.F$|F.D$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q09W.C3.07" qid="Q09W.C3.07" des="Soln e^x=k;reduction of expo eqn to simp quad" index7="14.3 | 14.3a" marks="6 marks" time="7" ttext="Roots of quadratic | Exponential functions"></q>
<q index1="|A.H$|D.A.C$|J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q09W.C3.08" qid="Q09W.C3.08" des="arcos x and arcos(x-1); geom transforms" index7="14.2a | 14.4a" marks="13 marks" time="16" ttext="Transformation of graphs | Trigonometric functions | Trigonometry"></q>
<q index1="|D.A.E$|D.A.I$|D.A.J|D.B.D$|D.B.E$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q09W.C3.09" qid="Q09W.C3.09" des="Diff quotient/product; int by subst/by parts" index7="14.4a | 14.4b | 14.5b" marks="16 marks" time="19" ttext="Logarithmic functions (differentiation) | Product | Quotients | Integration by substitution | Integration by parts"></q>
<q index1="|A.A$|A.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q09W.C4.01" qid="Q09W.C4.01" des="Factor thrm/simplify rational fn; Remainder thrm" index7="15.1a | 15.1b" marks="8 marks" time="10" ttext="Factor theorem | Remainder theorem"></q>
<q index1="|J|J.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q09W.C4.02" qid="Q09W.C4.02" des="Rsin(x-a) format to find min value exp" index7="15.4 | 15.4a" marks="6 marks" time="7" ttext="Trigonometry | Sum or diff of 2 angles"></q>
<q index1="|D.B.F$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q09W.C4.03" qid="Q09W.C4.03" des="Mainly PFs(repeated factor) to find integral" index7="15.1c | 15.1d | 15.6d" marks="13 marks" time="16" ttext="Integration using partial fractions"></q>
<q index1="|H.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q09W.C4.04" qid="Q09W.C4.04" des="Binomial expansions of (1-x)^1/2 and (4-x)^1/2" index7="15.3a" marks="7 marks" time="8" ttext="Binomial expansion"></q>
<q index1="|J|J.A$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q09W.C4.05" qid="Q09W.C4.05" des="Double angle formulae; eqn type axy+bx=0" index7="15.4b" marks="9 marks" time="11" ttext="Trigonometry | Double angle"></q>
<q index1="|D.A.G$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q09W.C4.06" qid="Q09W.C4.06" des="Implicit diff to find gradient; problem re stat pt" index7="15.6c" marks="10 marks" time="12" ttext="Implicit functions"></q>
<q index1="|F.D$|F.E$|P|P.A$|P.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q09W.C4.07" qid="Q09W.C4.07" des="Soln 1st order d.e. with practical reference" index7="15.5 | 15.6b" marks="10 marks" time="12" ttext="Exponential functions | Logarithmic function | Differential equations | Differential equations - 1st order | Variable separable"></q>
<q index1="|C|C.A$|C.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q09W.C4.08" qid="Q09W.C4.08" des="Involved vector qu testing all aspects of syll" index7="15.7 | 15.7a | 15.7b | 15.7c" marks="12 marks" time="14" ttext="Vectors | Equations of lines | Scalar product"></q>
<q index1="|K$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q09W.P1.01" qid="Q09W.P1.01" des="Standard step-by-step" index7="16.6 | 16.6b" marks="5 marks" time="6" ttext="Numerical methods"></q>
<q index1="|A.F$|L|L.A$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q09W.P1.02" qid="Q09W.P1.02" des="Complex conj for 2nd root; use Sum and Prod" index7="16.2 | 16.3" marks="5 marks" time="6" ttext="Roots of quadratic | Complex Numbers | Use of x + iy"></q>
<q index1="|J|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q09W.P1.03" qid="Q09W.P1.03" des="General soln of tan(a - 3x) = b" index7="16.7" marks="5 marks" time="6" ttext="Trigonometry"></q>
<q index1="|I.A$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q09W.P1.04" qid="Q09W.P1.04" des="Use sigma(r^2 and r); sigma from (n+1) to 2n" index7="16.4" marks="7 marks" time="8" ttext="Finite series"></q>
<q index1="|M$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q09W.P1.05" qid="Q09W.P1.05" des="2 X 2 matrices; sum/prod; matrix transforms" index7="16.8" marks="12 marks" time="14" ttext="Matrices"></q>
<q index1="|A|F.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q09W.P1.06" qid="Q09W.P1.06" des="Rat.fn; asyms/axes intersects/sketch/ineqn" index7="16.1 | 16.1a | 16.1b" marks="10 marks" time="12" ttext="Algebra | Rational functions"></q>
<q index1="|B.B$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q09W.P1.07" qid="Q09W.P1.07" des="(Poss test) coord geom line eqns/axis intersect" index7="16.1" marks="10 marks" time="12" ttext="Straight lines"></q>
<q index1="|D.B.B$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q09W.P1.08" qid="Q09W.P1.08" des="Evaluation (if possible) of 3 improper integrals" index7="16.5b" marks="7 marks" time="8" ttext="Integration of non-integer powers of x"></q>
<q index1="|A.F$|B.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q09W.P1.09" qid="Q09W.P1.09" des="Hyperbola; asyms/sketch/intersect line/discrim" index7="16.1d" marks="14 marks" time="17" ttext="Roots of quadratic | Conic sections"></q>
<q index1="|G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q09W.P2.01" qid="Q09W.P2.01" des="cosh 2x used in eqn linking cosh 2x and sinh x" index7="17.7" marks="9 marks" time="11" ttext="Hyperbolic functions"></q>
<q index1="|L|L.B$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q09W.P2.02" qid="Q09W.P2.02" des="Simple locus involving circle; find range(arg z)" index7="17.2 | 17.2a | 17.2b" marks="8 marks" time="10" ttext="Complex Numbers | Loci"></q>
<q index1="|I.A$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q09W.P2.03" qid="Q09W.P2.03" des="Method of diffs in typically structured question" index7="17.5" marks="8 marks" time="10" ttext="Finite series"></q>
<q index1="|A|A.G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q09W.P2.04" qid="Q09W.P2.04" des="Roots/coeffs cubic; non-real roots in conj pairs" index7="17.1" marks="13 marks" time="16" ttext="Algebra | Roots of polynomials"></q>
<q index1="|D.A|D.B|G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q09W.P2.05" qid="Q09W.P2.05" des="Diff(cosh x); sinh(2x) in subst leading to arc tan" index7="17.6 | 17.7" marks="7 marks" time="8" ttext="Differentiation | Integration | Hyperbolic functions"></q>
<q index1="|E$|I.A$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q09W.P2.06" qid="Q09W.P2.06" des="Std induction proof applied to sum of series" index7="17.4" marks="7 marks" time="8" ttext="Proof by induction | Finite series"></q>
<q index1="|D.A|D.C$|G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q09W.P2.07" qid="Q09W.P2.07" des="Involves deriv (arcosh 1/x); calc arc length" index7="17.7 | 17.8" marks="12 marks" time="14" ttext="Differentiation | Arc Length and Area of Surf. Revol | Hyperbolic functions"></q>
<q index1="|L|L.C$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q09W.P2.08" qid="Q09W.P2.08" des="Use of e^(i theta) to assist soln of quad in z^4" index7="17.2 | 17.2b | 17.3 | 17.3b" marks="11 marks" time="13" ttext="Complex Numbers | De Moivre's Theorem"></q>
<q index1="|K$|P.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q09W.P3.01" qid="Q09W.P3.01" des="Use Euler/improved Euler (both quoted)" index7="18.4c" marks="8 marks" time="10" ttext="Numerical methods | Differential equations - 1st order"></q>
<q index1="|P.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q09W.P3.02" qid="Q09W.P3.02" des="(Verify) integ factor to find genl soln 1st ord DE" index7="18.4a" marks="7 marks" time="8" ttext="Differential equations - 1st order"></q>
<q index1="|O|O.B$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q09W.P3.03" qid="Q09W.P3.03" des="Std polar area; Integral cos^2(x) sin(x) reqd" index7="18.2 | 18.2b" marks="6 marks" time="7" ttext="Polar co-ordinates | Areas"></q>
<q index1="|D.B.E$|I.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q09W.P3.04" qid="Q09W.P3.04" des="'By parts' integral; lim (x ln x) as x tends 0 reqd" index7="18.1b | 18.1c" marks="6 marks" time="7" ttext="Integration by parts | Improper integrals"></q>
<q index1="|O|O.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q09W.P3.05" qid="Q09W.P3.05" des="Basic ideas polar coords; also find cartes eqn" index7="18.2 | 18.2a" marks="13 marks" time="16" ttext="Polar co-ordinates | Cartesian equations"></q>
<q index1="|F.D$|F.E$|H.C$|I|I.E$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q09W.P3.06" qid="Q09W.P3.06" des="Varied std exps/Maclaurin; find lim rational fn" index7="18.1 | 18.1a | 18.1b | 18.1d" marks="16 marks" time="19" ttext="Exponential functions | Logarithmic function | Binomial expansion | Series and limits | Maclaurin series"></q>
<q index1="|P.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q09W.P3.07" qid="Q09W.P3.07" des="Subst (std but 'involved') to solve 2nd ord DE" index7="18.5 | 18.5a" marks="19 marks" time="23" ttext="Differential Equations - 2nd order"></q>
<q index1="|C|C.A$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q09W.P4.01" qid="Q09W.P4.01" des="Dir cosines; express eqn line in form (r-a) X b=0" index7="19.1 | 19.1c" marks="6 marks" time="7" ttext="Vectors | Equations of lines"></q>
<q index1="|M$|N.A$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q09W.P4.02" qid="Q09W.P4.02" des="Involves use of det(AB)=detA.detB; transposes" index7="19.2a | 19.4" marks="6 marks" time="7" ttext="Matrices | Evaluate determinants"></q>
<q index1="|C|C.C$|C.D$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q09W.P4.03" qid="Q09W.P4.03" des="Involves sc tr prod; area; linear dependence" index7="19.1 | 19.1a | 19.1b | 19.5" marks="8 marks" time="10" ttext="Vectors | Scalar product | Vector product"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q09W.P4.04" qid="Q09W.P4.04" des="Given e-value; find e-vector/other e-values" index7="19.2d" marks="11 marks" time="13" ttext="Matrices"></q>
<q index1="|N|N.A$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q09W.P4.05" qid="Q09W.P4.05" des="3X3 determinant expansion and factorisation" index7="19.4" marks="7 marks" time="8" ttext="Determinants | Evaluate determinants"></q>
<q index1="|C|C.A$|C.B$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q09W.P4.06" qid="Q09W.P4.06" des="Angle between and int pt of line/plane" index7="19.1 | 19.1c" marks="12 marks" time="14" ttext="Vectors | Equations of lines | Equations of planes"></q>
<q index1="|C.B$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q09W.P4.07" qid="Q09W.P4.07" des="Mainly soln 3 lin eqns/3 unknowns; geom sig" index7="19.1d | 19.3" marks="12 marks" time="14" ttext="Equations of planes"></q>
<q index1="|M$|N|N.A$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q09W.P4.08" qid="Q09W.P4.08" des="Find geom sig 2X2 matrix trans;also ellipse use" index7="19.2b | 19.4" marks="13 marks" time="16" ttext="Matrices | Determinants | Evaluate determinants"></q>
<q index1="|A.E$|B.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q09S.C1.01" qid="Q09S.C1.01" des="Grad/eqn of perp line/intersection pt 2 lines" index7="12.2a" marks="8 marks" time="10" ttext="Simultaneous equations | Straight lines"></q>
<q index1="|A.I$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q09S.C1.02" qid="Q09S.C1.02" des="Rationalise denom/Also square e.g. 2(sqrt 5)" index7="12.1a" marks="7 marks" time="8" ttext="Surds/indices"></q>
<q index1="|D.A|D.A.J.1$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q09S.C1.03" qid="Q09S.C1.03" des="Stationary pt involving 2nd deriv/eqn tgt" index7="12.3b | 12.3c" marks="13 marks" time="16" ttext="Differentiation | Maxima and minima"></q>
<q index1="|A.A$|A.B$|A.F$|D.B.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q09S.C1.04" qid="Q09S.C1.04" des="(Long) factors of cubic/area betwn curve/line" index7="12.1b | 12.1e | 12.4 | 12.4a | 12.4b" marks="17 marks" time="20" ttext="Factor theorem | Remainder theorem | Roots of quadratic | Integration of polynomials"></q>
<q index1="|B.A$|B.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q09S.C1.05" qid="Q09S.C1.05" des="Circle: centre/radius/eqn of tgt to be found" index7="12.2b | 12.2c" marks="11 marks" time="13" ttext="Circle | Straight lines"></q>
<q index1="|A.C$|B.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q09S.C1.06" qid="Q09S.C1.06" des="Complete square; min value quad; line length" index7="12.1b | 12.2a" marks="10 marks" time="12" ttext="Completing the square | Straight lines"></q>
<q index1="|A.D$|A.E$|A.F$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q09S.C1.07" qid="Q09S.C1.07" des="Condition real roots quad/soln subseq ineqn" index7="12.1c | 12.1d" marks="9 marks" time="11" ttext="Inequalities | Simultaneous equations | Roots of quadratic"></q>
<q index1="|J|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q09S.C2.01" qid="Q09S.C2.01" des="Std cosine rule to find angle; area triangle" index7="13.3a" marks="5 marks" time="6" ttext="Trigonometry"></q>
<q index1="|D.B|H.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q09S.C2.02" qid="Q09S.C2.02" des="Binom exp; def integral involves neg int powers " index7="13.2d | 13.6" marks="8 marks" time="10" ttext="Integration | Binomial expansion"></q>
<q index1="|H|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q09S.C2.03" qid="Q09S.C2.03" des="Interpretation of simple recurrence; also limit" index7="13.2a" marks="7 marks" time="8" ttext="Sequences and series"></q>
<q index1="|A.H$|D.B|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q09S.C2.04" qid="Q09S.C2.04" des="Std trap rule; effect of stretch on eqn of curve" index7="13.1b | 13.6b" marks="6 marks" time="7" ttext="Transformation of graphs | Integration"></q>
<q index1="|B.B$|D.A|D.A.B$|D.A.J.1$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q09S.C2.05" qid="Q09S.C2.05" des="Find max point on and eqns tgts to curve" index7="13.5" marks="13 marks" time="16" ttext="Straight lines | Differentiation | Non-integer powers of x | Maxima and minima"></q>
<q index1="|J.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q09S.C2.06" qid="Q09S.C2.06" des="Given sector area/incl angle; find perimeter" index7="13.3b" marks="6 marks" time="7" ttext="Arc length/area of sectors/segments"></q>
<q index1="|A.E$|H.B$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q09S.C2.07" qid="Q09S.C2.07" des="GP; sum(infinity); sigma notation" index7="13.2c" marks="11 marks" time="13" ttext="Simultaneous equations | Geometric series"></q>
<q index1="|J|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q09S.C2.08" qid="Q09S.C2.08" des="2-part uses sin/cos =tan and sin^2 + cos^2 =1" index7="13.3c | 13.3d" marks="9 marks" time="11" ttext="Trigonometry"></q>
<q index1="|F.D$|F.E$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q09S.C2.09" qid="Q09S.C2.09" des="4-part; laws indices/logs/soln of a^x = b" index7="13.1a | 13.4a | 13.4b" marks="10 marks" time="12" ttext="Exponential functions | Logarithmic function"></q>
<q index1="|D.A.C$|D.A.J|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q09S.C3.01" qid="Q09S.C3.01" des="2-part; Iteration/Quot rule to find eqn normal" index7="14.4a | 14.4b | 14.6a | 14.6b" marks="10 marks" time="12" ttext="Trigonometric functions | Quotients | Numerical methods"></q>
<q index1="|F|F.A$|F.B$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q09S.C3.02" qid="Q09S.C3.02" des="Std fn qu; range/domain/inverse/composite" index7="14.1 | 14.1a | 14.1c" marks="10 marks" time="12" ttext="Functions | Range/domain | Inverse functions"></q>
<q index1="|J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q09S.C3.03" qid="Q09S.C3.03" des="Soln tan x = k;use sec^2=1+tan^2 for quad eqn" index7="14.2c" marks="8 marks" time="10" ttext="Trigonometry"></q>
<q index1="|F.F$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q09S.C3.04" qid="Q09S.C3.04" des="Sketch mod fn;solve mod eqn/ineqn;mappings" index7="14.1b | 14.1c" marks="12 marks" time="14" ttext="Modulus function"></q>
<q index1="|F.D$|F.E$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q09S.C3.05" qid="Q09S.C3.05" des="Solve ln x = k; subst to prod quad eqn in ln x" index7="14.3" marks="6 marks" time="7" ttext="Exponential functions | Logarithmic function"></q>
<q index1="|D.A|D.B|D.B.G.1$|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q09S.C3.06" qid="Q09S.C3.06" des="Vol rotation(y-axis); mid-ord; tgt eqn(chn rule)" index7="14.4 | 14.4b | 14.5 | 14.5c | 14.6 | 14.6c" marks="19 marks" time="23" ttext="Differentiation | Integration | Areas and volumes | Numerical methods"></q>
<q index1="|D.B.D$|D.B.E$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q09S.C3.07" qid="Q09S.C3.07" des="3-part; Integral (t - 1) ln t; subst; parts combined " index7="14.4a | 14.5b" marks="10 marks" time="12" ttext="Integration by substitution | Integration by parts"></q>
<q index1="|A.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q09S.C4.01" qid="Q09S.C4.01" des="Std Rem Th; Division of cubic by linear" index7="15.1a | 15.1c" marks="5 marks" time="6" ttext="Remainder theorem"></q>
<q index1="|B.B$|D.A.H$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q09S.C4.02" qid="Q09S.C4.02" des="Parametric qu testing eqn normal/cartes eqn" index7="15.2 | 15.6c" marks="11 marks" time="13" ttext="Straight lines | Parametric equations"></q>
<q index1="|H.C$|I.D$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q09S.C4.03" qid="Q09S.C4.03" des="Rational fn involving PFs and binom exps" index7="15.1d | 15.3a | 15.3b" marks="13 marks" time="15" ttext="Binomial expansion | Use of partial fractions"></q>
<q index1="|F.D$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q09S.C4.04" qid="Q09S.C4.04" des="Std exp decay; involves soln of a^x=b" index7="15.5" marks="6 marks" time="7" ttext="Exponential functions"></q>
<q index1="|D.A|D.A.G$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q09S.C4.05" qid="Q09S.C4.05" des="Implicit differentiation to find gradient" index7="15.6 | 15.6c" marks="5 marks" time="6" ttext="Differentiation | Implicit functions"></q>
<q index1="|J|J.A$|J.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q09S.C4.06" qid="Q09S.C4.06" des="3-part; sin 2x; cos 2x and R sin(x+a) formulae" index7="15.4 | 15.4a | 15.4b" marks="15 marks" time="18" ttext="Trigonometry | Double angle | Sum or diff of 2 angles"></q>
<q index1="|C|C.A$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q09S.C4.07" qid="Q09S.C4.07" des="Vectors; lengths and pt intersection of 2 lines" index7="15.7 | 15.7a | 15.7b" marks="10 marks" time="12" ttext="Vectors | Equations of lines"></q>
<q index1="|P|P.A$|P.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q09S.C4.08" qid="Q09S.C4.08" des="Pract prob involving soln 1st order DE(var sep)" index7="15.6b" marks="10 marks" time="12" ttext="Differential equations | Differential equations - 1st order | Variable separable"></q>
<q index1="|A.F$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q09S.P1.01" qid="Q09S.P1.01" des="Form eqn with roots (alpha)^2 and (beta)^2 " index7="16.3" marks="7 marks" time="8" ttext="Roots of quadratic"></q>
<q index1="|B.B$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q09S.P1.02" qid="Q09S.P1.02" des="Grad of chord; use limit to find grad curve" index7="16.5 | 16.5McLean" marks="8 marks" time="10" ttext="Straight lines"></q>
<q index1="|L|L.A$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q09S.P1.03" qid="Q09S.P1.03" des="Complex conjugate/addition/multiplication" index7="16.2" marks="7 marks" time="8" ttext="Complex Numbers | Use of x + iy"></q>
<q index1="|K$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q09S.P1.04" qid="Q09S.P1.04" des="Std reduction to linear law; interpretation" index7="16.6 | 16.6c" marks="7 marks" time="8" ttext="Numerical methods"></q>
<q index1="|J|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q09S.P1.05" qid="Q09S.P1.05" des="General solutions of cos(3x - a) = 1/2" index7="16.7" marks="9 marks" time="11" ttext="Trigonometry"></q>
<q index1="|A.H$|B.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q09S.P1.06" qid="Q09S.P1.06" des="Ellipse; axes intersections; stretch/translate" index7="16.1d" marks="11 marks" time="13" ttext="Transformation of graphs | Conic sections"></q>
<q index1="|A.I$|J|M$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q09S.P1.07" qid="Q09S.P1.07" des="Matrix rotate/reflect/enlarge; combinations" index7="16.8" marks="11 marks" time="13" ttext="Surds/indices | Trigonometry | Matrices"></q>
<q index1="|F.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q09S.P1.08" qid="Q09S.P1.08" des="Rational fn; asymptotes/line intersects; discrim" index7="16.1 | 16.1a" marks="15 marks" time="18" ttext="Rational functions"></q>
<q index1="|L|L.C$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q09S.P2.01" qid="Q09S.P2.01" des="Std use de Moivre's theorem/solve z^4=a+bi" index7="17.3a | 17.3c" marks="8 marks" time="10" ttext="Complex Numbers | De Moivre's Theorem"></q>
<q index1="|I.A$|I.D$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q09S.P2.02" qid="Q09S.P2.02" des="Simple PFs leading to method of differences;" index7="17.5" marks="8 marks" time="10" ttext="Finite series | Use of partial fractions"></q>
<q index1="|A.G$|L|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q09S.P2.03" qid="Q09S.P2.03" des="Cubic;conj pr roots; relation betwn roots/coeffs " index7="17.1 | 17.2 | 17.2a" marks="8 marks" time="10" ttext="Roots of polynomials | Complex Numbers"></q>
<q index1="|G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q09S.P2.04" qid="Q09S.P2.04" des="Log form artanh(x);sech^2(x) ident to solve eqn" index7="17.7" marks="15 marks" time="18" ttext="Hyperbolic functions"></q>
<q index1="|E$|L|L.C$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q09S.P2.05" qid="Q09S.P2.05" des="Prove de Moivre; use z + 1/z = 2 cos(theta)" index7="17.3 | 17.3a | 17.4" marks="12 marks" time="14" ttext="Proof by induction | Complex Numbers | De Moivre's Theorem"></q>
<q index1="|L|L.B$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q09S.P2.06" qid="Q09S.P2.06" des="Understanding and use of mod (z-a) = b" index7="17.2 | 17.2b" marks="12 marks" time="14" ttext="Complex Numbers | Loci"></q>
<q index1="|D.B|G$|J.C$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q09S.P2.07" qid="Q09S.P2.07" des="Connection betweewn ds/dx and dy/dx " index7="17.7 | 17.8" marks="12 marks" time="14" ttext="Integration | Hyperbolic functions | Arc length/area of sectors/segments"></q>
<q index1="|K$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q09S.P3.01" qid="Q09S.P3.01" des="Std Euler formulae to find approximations" index7="18.4c" marks="6 marks" time="7" ttext="Numerical methods"></q>
<q index1="|P.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q09S.P3.02" qid="Q09S.P3.02" des="1st order DE; integral (sin x cos x) needed" index7="18.4a" marks="9 marks" time="11" ttext="Differential equations - 1st order"></q>
<q index1="|B|B.A$|O|O.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q09S.P3.03" qid="Q09S.P3.03" des="Circle geom; cartesian / polar versions" index7="18.2a" marks="8 marks" time="10" ttext="Co-ordinate geometry | Circle | Polar co-ordinates | Cartesian equations"></q>
<q index1="|I.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q09S.P3.04" qid="Q09S.P3.04" des="Eval improper int involving logs/limiting process" index7="18.1b | 18.1c" marks="5 marks" time="6" ttext="Improper integrals"></q>
<q index1="|P.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q09S.P3.05" qid="Q09S.P3.05" des="2nd order DE; AE cmplx roots; PI format given" index7="18.5 | 18.5a | 18.5b" marks="11 marks" time="13" ttext="Differential Equations - 2nd order"></q>
<q index1="|I|I.E$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q09S.P3.06" qid="Q09S.P3.06" des="Maclaurin for (9+tan x)^0.5; also limit process" index7="18.1 | 18.1a | 18.1b | 18.1d" marks="10 marks" time="12" ttext="Series and limits | Maclaurin series"></q>
<q index1="|O|O.B$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q09S.P3.07" qid="Q09S.P3.07" des="Polar: area 1st curve; sketch 2nd curve; int pts " index7="18.2 | 18.2a | 18.2b" marks="14 marks" time="17" ttext="Polar co-ordinates | Areas"></q>
<q index1="|P.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q09S.P3.08" qid="Q09S.P3.08" des="Use subst and derivs to solve 2nd order d.e." index7="18.5 | 18.5a | 18.5b" marks="12 marks" time="14" ttext="Differential Equations - 2nd order"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q09S.P4.01" qid="Q09S.P4.01" des="Product of 2X3 and 3X2 matrices; singularity" index7="19.2a" marks="5 marks" time="6" ttext="Matrices"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q09S.P4.02" qid="Q09S.P4.02" des="3 D matrix transforms; reflect/rotate/composite" index7="19.2a | 19.2c" marks="8 marks" time="10" ttext="Matrices"></q>
<q index1="|C|C.A$|C.B$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q09S.P4.03" qid="Q09S.P4.03" des="Eqn plane using r.n=d; non-intersect line/plane" index7="19.1 | 19.1c" marks="8 marks" time="10" ttext="Vectors | Equations of lines | Equations of planes"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q09S.P4.04" qid="Q09S.P4.04" des="Unique/consistent eqn set; invar pt 3 X 3 trans" index7="19.2c | 19.3" marks="12 marks" time="14" ttext="Matrices"></q>
<q index1="|C|C.C$|C.D$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q09S.P4.05" qid="Q09S.P4.05" des="Sc tr prod/coplanar/vol llppd; dir ratios/cosines" index7="19.1b | 19.1c" marks="10 marks" time="12" ttext="Vectors | Scalar product | Vector product"></q>
<q index1="|M$|N.A$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q09S.P4.06" qid="Q09S.P4.06" des="2X2 trans; find e-value/vector; describe shear" index7="19.2a | 19.2b | 19.2d" marks="12 marks" time="14" ttext="Matrices | Evaluate determinants"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q09S.P4.07" qid="Q09S.P4.07" des="Diagonalisation 2 X 2 matrix; e-values/vectors" index7="19.2a | 19.2d" marks="13 marks" time="16" ttext="Matrices"></q>
<q index1="|M$|N.A$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q09S.P4.08" qid="Q09S.P4.08" des="3X3 matrices; expansion/product/factorise" index7="19.2a | 19.4" marks="7 marks" time="8" ttext="Matrices | Evaluate determinants"></q>
<q index1="|B.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q08W.C1.01" qid="Q08W.C1.01" des="Basic principles incl mid pt/paralll/perp" index7="12.2a" marks="11 marks" time="13" ttext="Straight lines"></q>
<q index1="|D.A|D.A.J.1$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q08W.C1.02" qid="Q08W.C1.02" des="Stat pt;max/min incl 2nd deriv/inc/dec fn" index7="12.3a | 12.3b | 12.3c" marks="11 marks" time="13" ttext="Differentiation | Maxima and minima"></q>
<q index1="|A.I$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q08W.C1.03" qid="Q08W.C1.03" des="Gen surd manip including rationalising denom" index7="12.1a" marks="7 marks" time="8" ttext="Surds/indices"></q>
<q index1="|A.C$|B.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q08W.C1.04" qid="Q08W.C1.04" des="Find centre/radius of circle; prove line is tgt" index7="12.2b | 12.2d" marks="11 marks" time="13" ttext="Completing the square | Circle"></q>
<q index1="|A.C$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q08W.C1.05" qid="Q08W.C1.05" des="Manip of quad fn to interpret quad graph" index7="12.1b | 12.1f" marks="9 marks" time="11" ttext="Completing the square"></q>
<q index1="|A.A$|D.A|D.A.A$|D.B.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q08W.C1.06" qid="Q08W.C1.06" des="Long cubic factorisation/area/eqn normal" index7="12.1e | 12.2c | 12.3a | 12.4b" marks="18 marks" time="22" ttext="Factor theorem | Differentiation | Polynomials | Integration of polynomials"></q>
<q index1="|A.D$|A.F$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q08W.C1.07" qid="Q08W.C1.07" des="Distinct roots quad eqn/soln quad inequality" index7="12.1b | 12.1d" marks="8 marks" time="10" ttext="Inequalities | Roots of quadratic"></q>
<q index1="|J.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q08W.C2.01" qid="Q08W.C2.01" des="Std use of area of sector and length of arc" index7="13.3b" marks="6 marks" time="7" ttext="Arc length/area of sectors/segments"></q>
<q index1="|H.A$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q08W.C2.02" qid="Q08W.C2.02" des="AP; find 101st term and sum of 100 terms" index7="13.2b" marks="5 marks" time="6" ttext="Arithmetic series"></q>
<q index1="|J|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q08W.C2.03" qid="Q08W.C2.03" des="Std use of sine rule and area of triangle" index7="13.3a" marks="6 marks" time="7" ttext="Trigonometry"></q>
<q index1="|D.B|D.B.H$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q08W.C2.04" qid="Q08W.C2.04" des="Using trapezium rule" index7="13.6b" marks="4 marks" time="5" ttext="Integration | Trapezium rule"></q>
<q index1="|B.B$|D.A|D.A.B$|D.A.J.1$|D.B|D.B.B$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q08W.C2.05" qid="Q08W.C2.05" des="Eqn normal; max pt; area of region" index7="13.5 | 13.6a" marks="20 marks" time="24" ttext="Straight lines | Differentiation | Non-integer powers of x | Maxima and minima | Integration | Integration of non-integer powers of x"></q>
<q index1="|H.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q08W.C2.06" qid="Q08W.C2.06" des="Binomial involving (1+ax)^n" index7="13.2d" marks="10 marks" time="12" ttext="Binomial expansion"></q>
<q index1="|F.E$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q08W.C2.07" qid="Q08W.C2.07" des="Std use of laws of logarithms" index7="13.4a" marks="4 marks" time="5" ttext="Logarithmic function"></q>
<q index1="|A.H$|F.D$|F.E$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q08W.C2.08" qid="Q08W.C2.08" des="Transformations/equations based on 3^x" index7="13.1a | 13.1b | 13.4b" marks="12 marks" time="14" ttext="Transformation of graphs | Exponential functions | Logarithmic function"></q>
<q index1="|J|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q08W.C2.09" qid="Q08W.C2.09" des="Use of pythag identity; soln of cos 3x = a" index7="13.3c | 13.3d" marks="8 marks" time="10" ttext="Trigonometry"></q>
<q index1="|D.A.C$|D.A.I$|D.A.J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q08W.C3.01" qid="Q08W.C3.01" des="Chain rule; prod(involving trig) and quotient" index7="14.4a | 14.4b" marks="7 marks" time="8" ttext="Trigonometric functions | Product | Quotients"></q>
<q index1="|J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q08W.C3.02" qid="Q08W.C3.02" des="cot x eqn; 2nd eqn using cosec^2 = 1+cot^2" index7="14.2b | 14.2c" marks="8 marks" time="10" ttext="Trigonometry"></q>
<q index1="|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q08W.C3.03" qid="Q08W.C3.03" des="Std num methods involving location/iteration" index7="14.6a | 14.6b" marks="7 marks" time="8" ttext="Numerical methods"></q>
<q index1="|F|F.A$|F.B$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q08W.C3.04" qid="Q08W.C3.04" des="Std fn qu: range/composition/inverse" index7="14.1a" marks="9 marks" time="11" ttext="Functions | Range/domain | Inverse functions"></q>
<q index1="|D.B|D.B.D$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q08W.C3.05" qid="Q08W.C3.05" des="Hint leading to integral f '(x)/f(x); substitution" index7="14.5a | 14.5b" marks="9 marks" time="11" ttext="Integration | Integration by substitution"></q>
<q index1="|D.B|J|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q08W.C3.06" qid="Q08W.C3.06" des="cosec x sketch assoc with mid-ord rule" index7="14.2b | 14.6c" marks="6 marks" time="7" ttext="Integration | Trigonometry | Numerical methods"></q>
<q index1="|A.D$|A.H$|F.F$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q08W.C3.07" qid="Q08W.C3.07" des="Mapping with mod graph/equation/inequality" index7="14.1 | 14.1b | 14.1c" marks="12 marks" time="14" ttext="Inequalities | Transformation of graphs | Modulus function"></q>
<q index1="|D.B.C$|D.B.E$|F.D$|F.E$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q08W.C3.08" qid="Q08W.C3.08" des="Soln a^x=b; 'by parts'; stat pts; vol revolution" index7="14.3a | 14.5a | 14.5b | 14.5c" marks="17 marks" time="20" ttext="Integration of exponential functions | Integration by parts | Exponential functions | Logarithmic function"></q>
<q index1="|D.B|D.B.F$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q08W.C4.01" qid="Q08W.C4.01" des="Expressing in PFs and integrating" index7="15.1d | 15.6d" marks="5 marks" time="6" ttext="Integration | Integration using partial fractions"></q>
<q index1="|A.A$|F.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q08W.C4.02" qid="Q08W.C4.02" des="Factorise cubic/simp rational exp/Alg division" index7="15.1a | 15.1b | 15.1c" marks="10 marks" time="12" ttext="Factor theorem | Rational functions"></q>
<q index1="|H.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q08W.C4.03" qid="Q08W.C4.03" des="3 binom expansions/each based on (1+x)^1/2" index7="15.3a" marks="6 marks" time="7" ttext="Binomial expansion"></q>
<q index1="|F.D$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q08W.C4.04" qid="Q08W.C4.04" des="House prices based on exponential model" index7="15.5" marks="9 marks" time="11" ttext="Exponential functions"></q>
<q index1="|D.A|D.A.H$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q08W.C4.05" qid="Q08W.C4.05" des="Given param eqns/find tgt eqn and cartes eqn" index7="15.2 | 15.6c" marks="10 marks" time="12" ttext="Differentiation | Parametric equations"></q>
<q index1="|D.A|D.A.G$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q08W.C4.06" qid="Q08W.C4.06" des="Given implicit eqn/find grad (or use explicit eqn)" index7="15.6c" marks="5 marks" time="6" ttext="Differentiation | Implicit functions"></q>
<q index1="|J|J.A$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q08W.C4.07" qid="Q08W.C4.07" des="Std use of Rsin(x+a)/sin 2x/cos 2x formulae" index7="15.4a | 15.4b" marks="14 marks" time="17" ttext="Trigonometry | Double angle"></q>
<q index1="|P|P.A$|P.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q08W.C4.08" qid="Q08W.C4.08" des="Std separable variables DE/boundary cond" index7="15.6 | 15.6b" marks="5 marks" time="6" ttext="Differential equations | Differential equations - 1st order | Variable separable"></q>
<q index1="|C|C.A$|C.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q08W.C4.09" qid="Q08W.C4.09" des="Sc prod/find where perp to 1st line meets 2nd " index7="15.7 | 15.7a | 15.7b | 15.7c" marks="11 marks" time="13" ttext="Vectors | Equations of lines | Scalar product"></q>
<q index1="|L|L.A$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q08W.P1.01" qid="Q08W.P1.01" des="Knowledge of complex conjugate" index7="16.2" marks="4 marks" time="5" ttext="Complex Numbers | Use of x + iy"></q>
<q index1="|K$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q08W.P1.02" qid="Q08W.P1.02" des="Basic step-by-step" index7="16.6b" marks="5 marks" time="6" ttext="Numerical methods"></q>
<q index1="|J|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q08W.P1.03" qid="Q08W.P1.03" des="General soln of tan 4(x-a) = 1" index7="16.7" marks="5 marks" time="6" ttext="Trigonometry"></q>
<q index1="|I.A$|" index2="|5$|" index3="" index4="" index5="|2$|" index6="Q08W.P1.04" qid="Q08W.P1.04" des="Std results; find sigma(r^3 - 6r); simple divisibility" index7="16.4" marks="7 marks" time="8" ttext="Finite series"></q>
<q index1="|A.H$|B|B.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q08W.P1.05" qid="Q08W.P1.05" des="Hyperbola: asymptotes/eqns after translation" index7="16.1d" marks="8 marks" time="10" ttext="Transformation of graphs | Co-ordinate geometry | Conic sections"></q>
<q index1="|J|M$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q08W.P1.06" qid="Q08W.P1.06" des="Matrix mult/transforms; exact values sin/cos 60" index7="16.7 | 16.8" marks="10 marks" time="12" ttext="Trigonometry | Matrices"></q>
<q index1="|K$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q08W.P1.07" qid="Q08W.P1.07" des="Use grad curve=Lt(grad chord); N-Raphson" index7="16.5McLean | 16.6 | 16.6a" marks="12 marks" time="14" ttext="Numerical methods"></q>
<q index1="|A|A.F$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q08W.P1.08" qid="Q08W.P1.08" des="Form eqn with roots (alpha)^3 and (beta)^3" index7="16.3" marks="12 marks" time="14" ttext="Algebra | Roots of quadratic"></q>
<q index1="|A|A.D$|A.F$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q08W.P1.09" qid="Q08W.P1.09" des="Asymptotes rat fn graph; stat point (algebra)" index7="16.1 | 16.1a | 16.1b | 16.1c" marks="12 marks" time="14" ttext="Algebra | Inequalities | Roots of quadratic"></q>
<q index1="|L|L.C$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q08W.P2.01" qid="Q08W.P2.01" des="Express in form r e^i(theta); solve z^5 = a +ib" index7="17.2 | 17.2a | 17.3 | 17.3c" marks="8 marks" time="10" ttext="Complex Numbers | De Moivre's Theorem"></q>
<q index1="|I.A$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q08W.P2.02" qid="Q08W.P2.02" des="Standard method of differences" index7="17.5" marks="9 marks" time="11" ttext="Finite series"></q>
<q index1="|L|L.B$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q08W.P2.03" qid="Q08W.P2.03" des="Intersection of circle/line; interpret eqns" index7="17.2 | 17.2b" marks="11 marks" time="13" ttext="Complex Numbers | Loci"></q>
<q index1="|A|A.G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q08W.P2.04" qid="Q08W.P2.04" des="Std manip of roots of cubic; find new cubic eqn" index7="17.1" marks="14 marks" time="17" ttext="Algebra | Roots of polynomials"></q>
<q index1="|E$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q08W.P2.05" qid="Q08W.P2.05" des="Induction for sum of series (incl factorials)" index7="17.4" marks="7 marks" time="8" ttext="Proof by induction"></q>
<q index1="|L|L.C$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q08W.P2.06" qid="Q08W.P2.06" des="Find cos 3x (de M); deduce tan 3x; assoc eqn" index7="17.3 | 17.3a" marks="14 marks" time="17" ttext="Complex Numbers | De Moivre's Theorem"></q>
<q index1="|D.A|D.C$|G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q08W.P2.07" qid="Q08W.P2.07" des="Work with ln tanh(x/2); find deriv/arc length" index7="17.7 | 17.8" marks="12 marks" time="14" ttext="Differentiation | Arc Length and Area of Surf. Revol | Hyperbolic functions"></q>
<q index1="|P.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q08W.P3.01" qid="Q08W.P3.01" des="Standard use of Euler formulae" index7="18.4c" marks="6 marks" time="7" ttext="Differential equations - 1st order"></q>
<q index1="|J.D$|O|O.B$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q08W.P3.02" qid="Q08W.P3.02" des="Std area; extension involves area triangle" index7="18.2 | 18.2b" marks="9 marks" time="11" ttext="Sine and cosine rules/area of triangle | Polar co-ordinates | Areas"></q>
<q index1="|P.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q08W.P3.03" qid="Q08W.P3.03" des="Differential eqn: AE with complex roots" index7="18.5 | 18.5b" marks="10 marks" time="12" ttext="Differential Equations - 2nd order"></q>
<q index1="|D.B.E$|I|I.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q08W.P3.04" qid="Q08W.P3.04" des="Reason for integral being improper/evaluate" index7="18.1c" marks="7 marks" time="8" ttext="Integration by parts | Series and limits | Improper integrals"></q>
<q index1="|P.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q08W.P3.05" qid="Q08W.P3.05" des="Integrating factor for std 1st order linear DE" index7="18.4a" marks="9 marks" time="11" ttext="Differential equations - 1st order"></q>
<q index1="|O|O.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q08W.P3.06" qid="Q08W.P3.06" des="Cartes version polar eqn; sketch; int with line" index7="18.2 | 18.2a" marks="8 marks" time="10" ttext="Polar co-ordinates | Cartesian equations"></q>
<q index1="|I.E$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q08W.P3.07" qid="Q08W.P3.07" des="Maclaurin/derive exp of ln cos x; also Lt" index7="18.1a | 18.1b | 18.1d" marks="15 marks" time="18" ttext="Maclaurin series"></q>
<q index1="|P.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q08W.P3.08" qid="Q08W.P3.08" des="Subst to reduce to 2nd order DE/gen soln" index7="18.5 | 18.5a" marks="11 marks" time="13" ttext="Differential Equations - 2nd order"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q08W.P4.01" qid="Q08W.P4.01" des="Determine transformations rep by 2 matrices" index7="19.2c" marks="5 marks" time="6" ttext="Matrices"></q>
<q index1="|C.C$|C.D$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q08W.P4.02" qid="Q08W.P4.02" des="Vect prod; sc tr prod; geom relation" index7="19.1a | 19.1b | 19.1c" marks="7 marks" time="8" ttext="Scalar product | Vector product"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q08W.P4.03" qid="Q08W.P4.03" des="Geom prop of shear; eqn line of invariant pts" index7="19.2b" marks="8 marks" time="10" ttext="Matrices"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q08W.P4.04" qid="Q08W.P4.04" des="Testing eigenvalues/vectors; diagonalisation" index7="19.2d" marks="8 marks" time="10" ttext="Matrices"></q>
<q index1="|N|N.B$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q08W.P4.05" qid="Q08W.P4.05" des="3 lin eqns; find when unique soln/consistent" index7="19.3" marks="12 marks" time="14" ttext="Determinants | Use and solving equations"></q>
<q index1="|C|C.A$|C.B$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q08W.P4.06" qid="Q08W.P4.06" des="Vect eqn line/cartes; eqn plane;angle btwn" index7="19.1 | 19.1d" marks="15 marks" time="18" ttext="Vectors | Equations of lines | Equations of planes"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q08W.P4.07" qid="Q08W.P4.07" des="Char eqn; e-values/vectors;geom sig e-vectors" index7="19.2a | 19.2d" marks="20 marks" time="24" ttext="Matrices"></q>
<q index1="|A.E$|A.F$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q08S.C1.01" qid="Q08S.C1.01" des="Pts intersection of line and quadratic curve" index7="12.1c | 12.2d" marks="11 marks" time="13" ttext="Simultaneous equations | Roots of quadratic"></q>
<q index1="|A.I$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q08S.C1.02" qid="Q08S.C1.02" des="Multiplication and division of surds" index7="12.1a" marks="6 marks" time="7" ttext="Surds/indices"></q>
<q index1="|D.A|D.A.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q08S.C1.03" qid="Q08S.C1.03" des="Find 1st/2nd derivs of cubic; find max value" index7="12.3a | 12.3b | 12.3c" marks="13 marks" time="16" ttext="Differentiation | Polynomials"></q>
<q index1="|A.C$|A.H$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q08S.C1.04" qid="Q08S.C1.04" des="Compl square/min value/describe geom trans" index7="12.1b | 12.1f" marks="6 marks" time="7" ttext="Completing the square | Transformation of graphs"></q>
<q index1="|B.B$|D.B.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q08S.C1.05" qid="Q08S.C1.05" des="Eqn line;def integral;area between curve/line" index7="12.2a | 12.4b" marks="11 marks" time="13" ttext="Straight lines | Integration of polynomials"></q>
<q index1="|A.A$|A.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q08S.C1.06" qid="Q08S.C1.06" des="Factorisation cubic; associated graph" index7="12.1e | 12.1f" marks="11 marks" time="13" ttext="Factor theorem | Remainder theorem"></q>
<q index1="|B.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q08S.C1.07" qid="Q08S.C1.07" des="Find eqn circle given centre etc/eqn tgt " index7="12.2b | 12.2c" marks="10 marks" time="12" ttext="Circle"></q>
<q index1="|A.D$|A.F$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q08S.C1.08" qid="Q08S.C1.08" des="Real roots quad eqn; soln assoc quad ineqn" index7="12.1b | 12.1d" marks="7 marks" time="8" ttext="Inequalities | Roots of quadratic"></q>
<q index1="|A.I$|D.A|D.A.B$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q08S.C2.01" qid="Q08S.C2.01" des="Find eqn tangent; involves diff x^n,n rational" index7="13.1a | 13.5" marks="9 marks" time="11" ttext="Surds/indices | Differentiation | Non-integer powers of x"></q>
<q index1="|J.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q08S.C2.02" qid="Q08S.C2.02" des="Find arc length and segment perimeter " index7="13.3b" marks="6 marks" time="7" ttext="Arc length/area of sectors/segments"></q>
<q index1="|H.B$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q08S.C2.03" qid="Q08S.C2.03" des="GP: nth term/sum n terms/sum to infinity" index7="13.2c" marks="7 marks" time="8" ttext="Geometric series"></q>
<q index1="|J|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q08S.C2.04" qid="Q08S.C2.04" des="Testing cosine rule and area of triangle" index7="13.3a" marks="8 marks" time="10" ttext="Trigonometry"></q>
<q index1="|F.E$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q08S.C2.05" qid="Q08S.C2.05" des="General understanding of logs; laws of logs" index7="13.4a" marks="5 marks" time="6" ttext="Logarithmic function"></q>
<q index1="|H|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q08S.C2.06" qid="Q08S.C2.06" des="Recurrence;find specific values and limit" index7="13.2a" marks="9 marks" time="11" ttext="Sequences and series"></q>
<q index1="|D.B|H.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q08S.C2.07" qid="Q08S.C2.07" des="Cubic expansion; def integral with neg powers" index7="13.2d | 13.6" marks="9 marks" time="11" ttext="Integration | Binomial expansion"></q>
<q index1="|A.H$|D.B|F.D$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q08S.C2.08" qid="Q08S.C2.08" des="Std trap rule; transforms; soln a^x = b" index7="13.1b | 13.4b | 13.6b" marks="14 marks" time="17" ttext="Transformation of graphs | Integration | Exponential functions"></q>
<q index1="|J|J.A$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q08S.C2.09" qid="Q08S.C2.09" des="2 part; soln sin 2x = a/eqn using sin/cos=tan " index7="13.3c | 13.3d" marks="8 marks" time="10" ttext="Trigonometry | Double angle"></q>
<q index1="|D.A|D.A.E$|D.A.I$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q08S.C3.01" qid="Q08S.C3.01" des="Diff involving chain rule/ln fn/product" index7="14.4a | 14.4b" marks="7 marks" time="8" ttext="Differentiation | Logarithmic functions (differentiation) | Product"></q>
<q index1="|J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q08S.C3.02" qid="Q08S.C3.02" des="Trig eqns with sec x and uing sec^2 = 1+tan^2" index7="14.2 | 14.2b | 14.2c" marks="9 marks" time="11" ttext="Trigonometry"></q>
<q index1="|D.A.C$|D.A.I$|D.B.E$|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q08S.C3.03" qid="Q08S.C3.03" des="Stat pt/ numerical methods/ int by parts" index7="14.4a | 14.4b | 14.5a | 14.5b | 14.6 | 14.6a | 14.6b" marks="14 marks" time="17" ttext="Trigonometric functions | Product | Integration by parts | Numerical methods"></q>
<q index1="|F.A$|F.B$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q08S.C3.04" qid="Q08S.C3.04" des="fn qu involves range/inverse/composition" index7="14.1a" marks="8 marks" time="10" ttext="Range/domain | Inverse functions"></q>
<q index1="|A.H$|F.F$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q08S.C3.05" qid="Q08S.C3.05" des="Gen transform incl mod/series of transforms" index7="14.1b | 14.1c" marks="14 marks" time="17" ttext="Transformation of graphs | Modulus function"></q>
<q index1="|D.A|D.A.D$|D.B|D.B.C$|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q08S.C3.06" qid="Q08S.C3.06" des="Grad/mid-ord rule/vol of expo function" index7="14.4a | 14.5a | 14.5c | 14.6 | 14.6c" marks="13 marks" time="16" ttext="Differentiation | Exponential functions (differentiation) | Integration | Integration of exponential functions | Numerical methods"></q>
<q index1="|D.A|D.A.C$|D.A.J|D.B.D$|J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q08S.C3.07" qid="Q08S.C3.07" des="Trig identities in diff and integration by subst" index7="14.2b | 14.2c | 14.4a | 14.4b | 14.5b" marks="10 marks" time="12" ttext="Differentiation | Trigonometric functions | Quotients | Integration by substitution | Trigonometry"></q>
<q index1="|A.A$|A.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q08S.C4.01" qid="Q08S.C4.01" des="Cubic factorisation/cancellation in rational fn" index7="15.1a | 15.1b | 15.1c" marks="9 marks" time="11" ttext="Factor theorem | Remainder theorem"></q>
<q index1="|B.B$|D.A|D.A.H$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q08S.C4.02" qid="Q08S.C4.02" des="Param form: find eqn normal and cartes eqn" index7="15.2 | 15.6c" marks="10 marks" time="12" ttext="Straight lines | Differentiation | Parametric equations"></q>
<q index1="|D.B|J.A$|J.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q08S.C4.03" qid="Q08S.C4.03" des="Derive formula for sin3x/ Integrate sin^3(x)" index7="15.4a | 15.4b | 15.6" marks="8 marks" time="10" ttext="Integration | Double angle | Sum or diff of 2 angles"></q>
<q index1="|H.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q08S.C4.04" qid="Q08S.C4.04" des="Exp (1-x)^1/4 and (81-16x)^1/4; num approx" index7="15.3a" marks="7 marks" time="8" ttext="Binomial expansion"></q>
<q index1="|J|J.A$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q08S.C4.05" qid="Q08S.C4.05" des="Formulae for cos(A-B) and tan 2x used" index7="15.4a | 15.4b" marks="10 marks" time="12" ttext="Trigonometry | Double angle"></q>
<q index1="|D.B.F$|P.A$|P.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q08S.C4.06" qid="Q08S.C4.06" des="PFs for simple integral and use in diff eqn" index7="15.1d | 15.6b | 15.6d" marks="10 marks" time="12" ttext="Integration using partial fractions | Differential equations - 1st order | Variable separable"></q>
<q index1="|C.A$|C.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q08S.C4.07" qid="Q08S.C4.07" des="Distance betwn 2 pts and angle betwn 2 lines" index7="15.7a | 15.7c" marks="12 marks" time="14" ttext="Equations of lines | Scalar product"></q>
<q index1="|F.D$|F.E$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q08S.C4.08" qid="Q08S.C4.08" des="Exponential decay; soln of e^x = 13" index7="15.5 | 15.6b" marks="9 marks" time="11" ttext="Exponential functions | Logarithmic function"></q>
<q index1="|A|A.F$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q08S.P1.01" qid="Q08S.P1.01" des="Std manip; find quad eqn with given roots" index7="16.3" marks="8 marks" time="10" ttext="Algebra | Roots of quadratic"></q>
<q index1="|A.E$|L|L.A$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q08S.P1.02" qid="Q08S.P1.02" des="Complex conj; compare real and imag parts" index7="16.2" marks="6 marks" time="7" ttext="Simultaneous equations | Complex Numbers | Use of x + iy"></q>
<q index1="|D.B.B$|I.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q08S.P1.03" qid="Q08S.P1.03" des="Eval of improper integrals (where possible)" index7="16.5b" marks="7 marks" time="8" ttext="Integration of non-integer powers of x | Improper integrals"></q>
<q index1="|B.B$|K$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q08S.P1.04" qid="Q08S.P1.04" des="Linear law; (x,y) values/draw line graph/interp" index7="16.6c" marks="9 marks" time="11" ttext="Straight lines | Numerical methods"></q>
<q index1="|J|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q08S.P1.05" qid="Q08S.P1.05" des="Find general soln of eqn of form cos(ax+b)= c" index7="16.7" marks="7 marks" time="8" ttext="Trigonometry"></q>
<q index1="|M$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q08S.P1.06" qid="Q08S.P1.06" des="Multiplication of 2X2 matrices; identity matrix" index7="16.8" marks="7 marks" time="8" ttext="Matrices"></q>
<q index1="|A.H$|B.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q08S.P1.07" qid="Q08S.P1.07" des="Rect hyperbola; find eqns asymptotes" index7="16.1d" marks="10 marks" time="12" ttext="Transformation of graphs | Conic sections"></q>
<q index1="|M$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q08S.P1.08" qid="Q08S.P1.08" des="Matrix rep stretch; stretch followed by reflection" index7="16.8" marks="7 marks" time="8" ttext="Matrices"></q>
<q index1="|B.B$|B.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q08S.P1.09" qid="Q08S.P1.09" des="Intersect genl line/parabola; discrim to find tgts" index7="16.1d" marks="14 marks" time="17" ttext="Straight lines | Conic sections"></q>
<q index1="|F.D$|F.E$|G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q08S.P2.01" qid="Q08S.P2.01" des="Hyper fns expo forms; solve ay + b/y + c = 0" index7="17.7" marks="6 marks" time="7" ttext="Exponential functions | Logarithmic function | Hyperbolic functions"></q>
<q index1="|I|I.A$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q08S.P2.02" qid="Q08S.P2.02" des="Solve simp identity/ method of diffs to find sum" index7="17.5" marks="7 marks" time="8" ttext="Series and limits | Finite series"></q>
<q index1="|A.G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q08S.P2.03" qid="Q08S.P2.03" des="Manip relations betw roots and cfs cubic eqn" index7="17.1" marks="12 marks" time="14" ttext="Roots of polynomials"></q>
<q index1="|L|L.B$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q08S.P2.04" qid="Q08S.P2.04" des="Interp of circle/half-line loci eqns in Arg diag" index7="17.2 | 17.2b" marks="12 marks" time="14" ttext="Complex Numbers | Loci"></q>
<q index1="|G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q08S.P2.05" qid="Q08S.P2.05" des="Justify cosh 2x formula; find surface area" index7="17.7 | 17.8" marks="10 marks" time="12" ttext="Hyperbolic functions"></q>
<q index1="|D.B.D$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q08S.P2.06" qid="Q08S.P2.06" des="Basic alg subst reducing to std arc sin" index7="17.6" marks="5 marks" time="6" ttext="Integration by substitution"></q>
<q index1="|E$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q08S.P2.07" qid="Q08S.P2.07" des="Proof (structured) that n(n^2+5) is multiple of 6" index7="17.4" marks="9 marks" time="11" ttext="Proof by induction"></q>
<q index1="|D.B|L|L.C$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q08S.P2.08" qid="Q08S.P2.08" des="cos^4(x)sin^2(x) in terms mult angles; integrate" index7="17.3 | 17.3a" marks="14 marks" time="17" ttext="Integration | Complex Numbers | De Moivre's Theorem"></q>
<q index1="|K$|P.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q08S.P3.01" qid="Q08S.P3.01" des="Use std /improved Euler formulae (quoted)" index7="18.4 | 18.4c" marks="6 marks" time="7" ttext="Numerical methods | Differential equations - 1st order"></q>
<q index1="|P.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q08S.P3.02" qid="Q08S.P3.02" des="1st order DE using PI and CF; find general soln" index7="18.4a" marks="7 marks" time="8" ttext="Differential equations - 1st order"></q>
<q index1="|O|O.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q08S.P3.03" qid="Q08S.P3.03" des="Given cartesian equation / find polar equation" index7="18.2 | 18.2a" marks="6 marks" time="7" ttext="Polar co-ordinates | Cartesian equations"></q>
<q index1="|P|P.A$|P.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q08S.P3.04" qid="Q08S.P3.04" des="Subst to reduce 2nd order DE to pr of 1st order" index7="18.4a | 18.5 | 18.5c" marks="10 marks" time="12" ttext="Differential equations | Differential equations - 1st order | Differential Equations - 2nd order"></q>
<q index1="|D.B.E$|D.B.H$|I|I.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q08S.P3.05" qid="Q08S.P3.05" des="Value of improper integral showing limit process" index7="18.1b | 18.1c" marks="7 marks" time="8" ttext="Integration by parts | Trapezium rule | Series and limits | Improper integrals"></q>
<q index1="|P.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q08S.P3.06" qid="Q08S.P3.06" des="Std 2nd order DE; general/particular soln " index7="18.5 | 18.5b" marks="14 marks" time="17" ttext="Differential Equations - 2nd order"></q>
<q index1="|I.E$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q08S.P3.07" qid="Q08S.P3.07" des="Major part: Macl'rin series; minor: limit rat'l fn" index7="18.1 | 18.1a | 18.1b" marks="11 marks" time="13" ttext="Maclaurin series"></q>
<q index1="|O|O.B$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q08S.P3.08" qid="Q08S.P3.08" des="Polar eqn sketch/std area/area triangle" index7="18.2a | 18.2b" marks="14 marks" time="17" ttext="Polar co-ordinates | Areas"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q08S.P4.01" qid="Q08S.P4.01" des="Eigenvalues/eigenvectors of 2 X 2 matrix" index7="19.2d" marks="6 marks" time="7" ttext="Matrices"></q>
<q index1="|C|C.C$|C.D$|Q$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q08S.P4.02" qid="Q08S.P4.02" des="Sc/vect tr prod; parallel vectors; lin dep" index7="19.1 | 19.1a | 19.1b" marks="10 marks" time="12" ttext="Vectors | Scalar product | Vector product | Linear independence"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q08S.P4.03" qid="Q08S.P4.03" des="3 X 3 matrix; determine det and inverse" index7="19.2a" marks="7 marks" time="8" ttext="Matrices"></q>
<q index1="|C|C.A$|C.B$|C.C$|C.D$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q08S.P4.04" qid="Q08S.P4.04" des="Angle btw 2 planes and eqn line intersection" index7="19.1 | 19.1c" marks="11 marks" time="13" ttext="Vectors | Equations of lines | Equations of planes | Scalar product | Vector product"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q08S.P4.05" qid="Q08S.P4.05" des="Invariant points/lines; diagonalisation" index7="19.2b | 19.2d" marks="12 marks" time="14" ttext="Matrices"></q>
<q index1="|C|C.B$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q08S.P4.06" qid="Q08S.P4.06" des="3 planes/cartes eqns;(non) intersection pt/line" index7="19.1 | 19.1d" marks="13 marks" time="16" ttext="Vectors | Equations of planes"></q>
<q index1="|C|C.B$|M$|N.A$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q08S.P4.07" qid="Q08S.P4.07" des="Det/e-values of 3X3;vect eqn pl/find cartes" index7="19.1 | 19.1d | 19.2a | 19.2c | 19.2d" marks="13 marks" time="16" ttext="Vectors | Equations of planes | Matrices | Evaluate determinants"></q>
<q index1="|N|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q08S.P4.08" qid="Q08S.P4.08" des="Factorisation of determinants" index7="19.4" marks="3 marks" time="4" ttext="Determinants"></q>
<q index1="|A.A$|A.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q07W.C1.01" qid="Q07W.C1.01" des="Remainder theorem; cubic sketch" index7="12.1e | 12.1f" marks="11 marks" time="13" ttext="Factor theorem | Remainder theorem"></q>
<q index1="|B|B.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q07W.C1.02" qid="Q07W.C1.02" des="Grad line and perp; sim eqns; length of line" index7="12.2 | 12.2a" marks="11 marks" time="13" ttext="Co-ordinate geometry | Straight lines"></q>
<q index1="|A.I$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q07W.C1.03" qid="Q07W.C1.03" des="Division of surds; surd simplification" index7="12.1a" marks="8 marks" time="10" ttext="Surds/indices"></q>
<q index1="|B.A$|B.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q07W.C1.04" qid="Q07W.C1.04" des="Centre/radius; mid-pt of line; line intersection" index7="12.2a | 12.2b" marks="14 marks" time="17" ttext="Circle | Straight lines"></q>
<q index1="|D.A|D.A.J.1$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q07W.C1.05" qid="Q07W.C1.05" des="Max/min practical problem; 2nd derivative" index7="12.3a | 12.3b | 12.3c" marks="10 marks" time="12" ttext="Differentiation | Maxima and minima"></q>
<q index1="|D.A|D.B|D.B.G.1$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q07W.C1.06" qid="Q07W.C1.06" des="Including area under curve; eqn. tangent" index7="12.3a | 12.4b" marks="14 marks" time="17" ttext="Differentiation | Integration | Areas and volumes"></q>
<q index1="|A.D$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q07W.C1.07" qid="Q07W.C1.07" des="Discriminant for real roots of quadratic" index7="12.1d" marks="7 marks" time="8" ttext="Inequalities"></q>
<q index1="|J|J.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q07W.C2.01" qid="Q07W.C2.01" des="Sector area and perimeter" index7="13.3b" marks="5 marks" time="6" ttext="Trigonometry | Arc length/area of sectors/segments"></q>
<q index1="|D.B|D.B.H$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q07W.C2.02" qid="Q07W.C2.02" des="Using trapezium rule" index7="13.6b" marks="4 marks" time="5" ttext="Integration | Trapezium rule"></q>
<q index1="|A|A.I$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q07W.C2.03" qid="Q07W.C2.03" des="Simple indices" index7="13.1a" marks="5 marks" time="6" ttext="Algebra | Surds/indices"></q>
<q index1="|J|J.D$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q07W.C2.04" qid="Q07W.C2.04" des="Cosine rule; sin^2+cos^2=1; triangle area" index7="13.3a | 13.3c" marks="8 marks" time="10" ttext="Trigonometry | Sine and cosine rules/area of triangle"></q>
<q index1="|H|H.B$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q07W.C2.05" qid="Q07W.C2.05" des="GP including sum to infinity" index7="13.2c" marks="7 marks" time="8" ttext="Sequences and series | Geometric series"></q>
<q index1="|D.A|D.B|D.B.G.1$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q07W.C2.06" qid="Q07W.C2.06" des="Min point; eqn normal; area under curve" index7="13.5 | 13.6" marks="16 marks" time="19" ttext="Differentiation | Integration | Areas and volumes"></q>
<q index1="|H.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q07W.C2.07" qid="Q07W.C2.07" des="8th power; selection partic term in product" index7="13.2d" marks="7 marks" time="8" ttext="Binomial expansion"></q>
<q index1="|J|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q07W.C2.08" qid="Q07W.C2.08" des="Soln simple eqns; cos graph; geom transform" index7="13.3c | 13.3d" marks="12 marks" time="14" ttext="Trigonometry"></q>
<q index1="|A|F.E$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q07W.C2.09" qid="Q07W.C2.09" des="Laws of logarithms involving division/powers" index7="13.4a" marks="11 marks" time="13" ttext="Algebra | Logarithmic function"></q>
<q index1="|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q07W.C3.01" qid="Q07W.C3.01" des="Mid-ordinate rule" index7="14.6c" marks="4 marks" time="5" ttext="Numerical methods"></q>
<q index1="|J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q07W.C3.02" qid="Q07W.C3.02" des="Involving sec x; combination geom transforms" index7="14.2b" marks="4 marks" time="5" ttext="Trigonometry"></q>
<q index1="|F|F.A$|F.B$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q07W.C3.03" qid="Q07W.C3.03" des="Range/domain; inverse; composite fn" index7="14.1a" marks="9 marks" time="11" ttext="Functions | Range/domain | Inverse functions"></q>
<q index1="|D.B|D.B.D$|D.B.E$|D.B.G.1$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q07W.C3.04" qid="Q07W.C3.04" des="Parts; substitution; volume of revolution" index7="14.5b | 14.5c" marks="12 marks" time="14" ttext="Integration | Integration by substitution | Integration by parts | Areas and volumes"></q>
<q index1="|J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q07W.C3.05" qid="Q07W.C3.05" des="Cot/cosec equation; simple substitution" index7="14.2b" marks="8 marks" time="10" ttext="Trigonometry"></q>
<q index1="|D.A|D.A.A$|D.A.C$|D.A.E$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q07W.C3.06" qid="Q07W.C3.06" des="Diff: product; tan x; dx/dy; ln y; eqn tgt" index7="14.4a | 14.4b" marks="8 marks" time="10" ttext="Differentiation | Polynomials | Trigonometric functions | Logarithmic functions (differentiation)"></q>
<q index1="|A|F|F.F$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q07W.C3.07" qid="Q07W.C3.07" des="Simple mod functions; sketches; eqn/inequality" index7="14.1b" marks="9 marks" time="11" ttext="Algebra | Functions | Modulus function"></q>
<q index1="|J|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q07W.C3.08" qid="Q07W.C3.08" des="Inverse cosine; iteration calculations" index7="14.2a | 14.6b" marks="7 marks" time="8" ttext="Trigonometry | Numerical methods"></q>
<q index1="|D.A.D$|D.B.C$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q07W.C3.09" qid="Q07W.C3.09" des="(4 - e^2x) ref to graph; eqn normal; area" index7="14.4a | 14.5a" marks="14 marks" time="17" ttext="Exponential functions (differentiation) | Integration of exponential functions"></q>
<q index1="|D.A.H$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q07W.C4.01" qid="Q07W.C4.01" des="Eqn normal; conversion to cartesian" index7="15.2" marks="11 marks" time="13" ttext="Parametric equations"></q>
<q index1="|A.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q07W.C4.02" qid="Q07W.C4.02" des="Factorisation of cubic" index7="15.1a" marks="6 marks" time="7" ttext="Remainder theorem"></q>
<q index1="|D.B|J.A$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q07W.C4.03" qid="Q07W.C4.03" des="Quad eqn in sin x; integral using found result" index7="15.4b" marks="9 marks" time="10" ttext="Integration | Double angle"></q>
<q index1="|A|D.B.F$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q07W.C4.04" qid="Q07W.C4.04" des="Simplication rational exp; integral involving PFs" index7="15.1b | 15.6d" marks="10 marks" time="12" ttext="Algebra | Integration using partial fractions"></q>
<q index1="|H.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q07W.C4.05" qid="Q07W.C4.05" des="Binomial exp (1+x)^1/3 and (8+3x)^1/3" index7="15.3a" marks="7 marks" time="8" ttext="Binomial expansion"></q>
<q index1="|C.A$|C.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q07W.C4.06" qid="Q07W.C4.06" des="Finding angle of triangle; geometry of vectors" index7="15.7b | 15.7c" marks="13 marks" time="16" ttext="Equations of lines | Scalar product"></q>
<q index1="|J.A$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q07W.C4.07" qid="Q07W.C4.07" des="Involving tan 2x; simple identity proof" index7="15.4b" marks="6 marks" time="7" ttext="Double angle"></q>
<q index1="|P.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q07W.C4.08" qid="Q07W.C4.08" des="log/exp manipulation; practical problem" index7="15.5 | 15.6b" marks="13 marks" time="16" ttext="Variable separable"></q>
<q index1="|L|L.A$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q07W.P1.01" qid="Q07W.P1.01" des="Roots of quadratic eqn; expansion of (1+ i)^3" index7="16.2" marks="10 marks" time="12" ttext="Complex Numbers | Use of x + iy"></q>
<q index1="|M$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q07W.P1.02" qid="Q07W.P1.02" des="Addition/multiplication; assoc transforms" index7="16.8" marks="11 marks" time="13" ttext="Matrices"></q>
<q index1="|A.F$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q07W.P1.03" qid="Q07W.P1.03" des="Symmetric functions and manipulations" index7="16.1c" marks="8 marks" time="10" ttext="Roots of quadratic"></q>
<q index1="|F.G$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q07W.P1.04" qid="Q07W.P1.04" des="Includes interpretations from linear graph" index7="16.6c" marks="6 marks" time="7" ttext="Reduction to linear law"></q>
<q index1="|A|A.D$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q07W.P1.05" qid="Q07W.P1.05" des="Graph rational fn/asymptotes; assoc inequality" index7="16.1a | 16.1b" marks="10 marks" time="12" ttext="Algebra | Inequalities"></q>
<q index1="|I.A$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q07W.P1.06" qid="Q07W.P1.06" des="Sigma (r^2 ; r; 1) needed + associated problem" index7="16.4" marks="10 marks" time="12" ttext="Finite series"></q>
<q index1="|F|J|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q07W.P1.07" qid="Q07W.P1.07" des="Genl soln trig eqn; grad(curve)=limit grad(chord)" index7="16.5McLean | 16.7" marks="8 marks" time="10" ttext="Functions | Trigonometry"></q>
<q index1="|A.F$|B.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q07W.P1.08" qid="Q07W.P1.08" des="Hyperbola;sketch; inter line/curve;double roots" index7="16.1d" marks="12 marks" time="14" ttext="Roots of quadratic | Conic sections"></q>
<q index1="|G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q07W.P2.01" qid="Q07W.P2.01" des="Quad in sinh x; inverse sinh as nat log" index7="17.7" marks="7 marks" time="8" ttext="Hyperbolic functions"></q>
<q index1="|L|L.B$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q07W.P2.02" qid="Q07W.P2.02" des="Circle; perp bisector; region defined by ineqns" index7="17.2b" marks="8 marks" time="10" ttext="Complex Numbers | Loci"></q>
<q index1="|L|L.A$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q07W.P2.03" qid="Q07W.P2.03" des="Real/imag parts; simult eqns.; 3rd root cubic" index7="17.2 | 17.2a" marks="7 marks" time="8" ttext="Complex Numbers | Use of x + iy"></q>
<q index1="|D.C$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q07W.P2.04" qid="Q07W.P2.04" des="Involving sech t/tanh t; derivs and identities" index7="17.7 | 17.8" marks="18 marks" time="22" ttext="Arc Length and Area of Surf. Revol"></q>
<q index1="|E$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q07W.P2.05" qid="Q07W.P2.05" des="De Moivre's theorem proved and applied" index7="17.3a | 17.4" marks="14 marks" time="17" ttext="Proof by induction"></q>
<q index1="|L.C$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q07W.P2.06" qid="Q07W.P2.06" des="Cube roots unity" index7="17.3b" marks="12 marks" time="14" ttext="De Moivre's Theorem"></q>
<q index1="|I.A$|J|J.B$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q07W.P2.07" qid="Q07W.P2.07" des="Method of differences using tan(A - B) formula" index7="17.5" marks="9 marks" time="11" ttext="Finite series | Trigonometry | Sum or diff of 2 angles"></q>
<q index1="|P.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q07W.P3.01" qid="Q07W.P3.01" des="Euler and Improved Euler formulae" index7="18.4c" marks="9 marks" time="11" ttext="Differential equations - 1st order"></q>
<q index1="|O|O.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q07W.P3.02" qid="Q07W.P3.02" des="Conversion to cartesian form" index7="18.2a" marks="6 marks" time="7" ttext="Polar co-ordinates | Cartesian equations"></q>
<q index1="|P.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q07W.P3.03" qid="Q07W.P3.03" des="Integrating factor; finding particular solution" index7="18.4a" marks="9 marks" time="11" ttext="Differential equations - 1st order"></q>
<q index1="|D.B.E$|I.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q07W.P3.04" qid="Q07W.P3.04" des="Evaluation/including integration by parts" index7="18.1c" marks="8 marks" time="10" ttext="Integration by parts | Improper integrals"></q>
<q index1="|P.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q07W.P3.05" qid="Q07W.P3.05" des="AE(real diff)/CF/PI(c sin nx + d cos nx)" index7="18.5 | 18.5a | 18.5b" marks="12 marks" time="14" ttext="Differential Equations - 2nd order"></q>
<q index1="|I.E$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q07W.P3.06" qid="Q07W.P3.06" des="Including limiting form of expression" index7="18.1a | 18.1b" marks="16 marks" time="19" ttext="Maclaurin series"></q>
<q index1="|O|O.B$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q07W.P3.07" qid="Q07W.P3.07" des="Area; simple polar geometry" index7="18.2 | 18.2b" marks="15 marks" time="18" ttext="Polar co-ordinates | Areas"></q>
<q index1="|A.E$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q07W.P4.01" qid="Q07W.P4.01" des="Inconsistency proof" index7="19.3" marks="4 marks" time="5" ttext="Simultaneous equations"></q>
<q index1="|N|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q07W.P4.02" qid="Q07W.P4.02" des="Factorisation" index7="19.4" marks="7 marks" time="8" ttext="Determinants"></q>
<q index1="|C|C.D$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q07W.P4.03" qid="Q07W.P4.03" des="Vector product; triangle area; sc tr prod" index7="19.1a | 19.1b" marks="8 marks" time="10" ttext="Vectors | Vector product"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q07W.P4.04" qid="Q07W.P4.04" des="Transformations in 3 D" index7="19.2c" marks="9 marks" time="11" ttext="Matrices"></q>
<q index1="|C.B$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q07W.P4.05" qid="Q07W.P4.05" des="Angle between planes; cartesian form" index7="19.1c | 19.1d" marks="13 marks" time="16" ttext="Equations of planes"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q07W.P4.06" qid="Q07W.P4.06" des="Eigenvalues/eigenvectors; matrix algebra" index7="19.2a | 19.2d" marks="12 marks" time="14" ttext="Matrices"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q07W.P4.07" qid="Q07W.P4.07" des="Shear transform in 2 D; invariant lines; det" index7="19.2b" marks="10 marks" time="12" ttext="Matrices"></q>
<q index1="|N|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q07W.P4.08" qid="Q07W.P4.08" des="Evaluation; singular; general inverse algebra" index7="19.4" marks="12 marks" time="14" ttext="Determinants"></q>
<q index1="|B|B.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q07S.C1.01" qid="Q07S.C1.01" des="Basic involving gradient/equations/perp lines" index7="12.2 | 12.2a" marks="8 marks" time="10" ttext="Co-ordinate geometry | Straight lines"></q>
<q index1="|A.I$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q07S.C1.02" qid="Q07S.C1.02" des="Std manipulation including rationalising denom" index7="12.1a" marks="7 marks" time="8" ttext="Surds/indices"></q>
<q index1="|A.C$|B|B.C$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q07S.C1.03" qid="Q07S.C1.03" des="Parabola;vertex;transform;intersectn line/curve" index7="12.1 | 12.1f" marks="12 marks" time="14" ttext="Completing the square | Co-ordinate geometry | Conic sections"></q>
<q index1="|D.A|D.A.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q07S.C1.04" qid="Q07S.C1.04" des="Second deriv; max/min; rate of change" index7="12.3a | 12.3b | 12.3c" marks="13 marks" time="16" ttext="Differentiation | Polynomials"></q>
<q index1="|B|B.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q07S.C1.05" qid="Q07S.C1.05" des="Centre/radius; eqn normal; length tangent" index7="12.2 | 12.2b | 12.2c" marks="14 marks" time="17" ttext="Co-ordinate geometry | Circle"></q>
<q index1="|A.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q07S.C1.06" qid="Q07S.C1.06" des="Also area of region between curve and line" index7="12.1e | 12.4 | 12.4b" marks="14 marks" time="17" ttext="Factor theorem"></q>
<q index1="|A.D$|A.F$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q07S.C1.07" qid="Q07S.C1.07" des="Condition for real roots; quadratic inequality" index7="12.1b | 12.1d" marks="7 marks" time="8" ttext="Inequalities | Roots of quadratic"></q>
<q index1="|A.I$|D.B.B$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q07S.C2.01" qid="Q07S.C2.01" des="Principal laws indices; also integral x^1/2 " index7="13.1 | 13.1a | 13.6a" marks="8 marks" time="10" ttext="Surds/indices | Integration of non-integer powers of x"></q>
<q index1="|H.B$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q07S.C2.02" qid="Q07S.C2.02" des="Common ratio and sum " index7="13.2c" marks="7 marks" time="8" ttext="Geometric series"></q>
<q index1="|J.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q07S.C2.03" qid="Q07S.C2.03" des="Including area triangle and cosine rule" index7="13.3 | 13.3a | 13.3b" marks="10 marks" time="12" ttext="Arc length/area of sectors/segments"></q>
<q index1="|H.A$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q07S.C2.04" qid="Q07S.C2.04" des="Sum of n terms; simultaneous equations" index7="13.2b" marks="7 marks" time="8" ttext="Arithmetic series"></q>
<q index1="|D.A|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q07S.C2.05" qid="Q07S.C2.05" des="Involving x^-1 and x^-2; eqn of normal" index7="13.5" marks="12 marks" time="14" ttext="Differentiation"></q>
<q index1="|F.D$|K$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q07S.C2.06" qid="Q07S.C2.06" des="Trapezium rule; soln of a^x=b" index7="13.4b | 13.6b" marks="10 marks" time="12" ttext="Exponential functions | Numerical methods"></q>
<q index1="|J|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q07S.C2.07" qid="Q07S.C2.07" des="tan graph; sin/cos = tan; simple transforms" index7="13.3 | 13.3c" marks="13 marks" time="16" ttext="Trigonometry"></q>
<q index1="|F.E$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q07S.C2.08" qid="Q07S.C2.08" des="Laws of logarithms; interp as powers" index7="13.4 | 13.4a" marks="8 marks" time="10" ttext="Logarithmic function"></q>
<q index1="|D.A.E$|D.A.I$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q07S.C3.01" qid="Q07S.C3.01" des="Includes eqn of normal" index7="14.3" marks="7 marks" time="8" ttext="Logarithmic functions (differentiation) | Product"></q>
<q index1="|D.A|D.B|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q07S.C3.02" qid="Q07S.C3.02" des="Chain rule; volume; comb of transforms" index7="14.4b | 14.5c" marks="9 marks" time="11" ttext="Differentiation | Integration"></q>
<q index1="|J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q07S.C3.03" qid="Q07S.C3.03" des="Simple cosec eqn; sketch of mod(cosec x) " index7="14.1b | 14.2b" marks="7 marks" time="8" ttext="Trigonometry"></q>
<q index1="|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q07S.C3.04" qid="Q07S.C3.04" des="Simpson's rule; iteration; cobweb/staircase" index7="14.6 | 14.6b | 14.6c" marks="12 marks" time="14" ttext="Numerical methods"></q>
<q index1="|F|F.A$|F.B$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q07S.C3.05" qid="Q07S.C3.05" des="Range; composition; inverse" index7="14.1a" marks="9 marks" time="11" ttext="Functions | Range/domain | Inverse functions"></q>
<q index1="|D.B.D$|D.B.E$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q07S.C3.06" qid="Q07S.C3.06" des="Parts; def integral involving substitution" index7="14.5b" marks="9 marks" time="11" ttext="Integration by substitution | Integration by parts"></q>
<q index1="|D.A.D$|D.A.I$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q07S.C3.07" qid="Q07S.C3.07" des="Nature of stationary points" index7="14.3 | 14.4a | 14.4b" marks="10 marks" time="12" ttext="Exponential functions (differentiation) | Product"></q>
<q index1="|D.A|D.A.C$|D.A.J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q07S.C3.08" qid="Q07S.C3.08" des="Quotient rule; trig identity" index7="14.2 | 14.2c | 14.4 | 14.4b" marks="12 marks" time="14" ttext="Differentiation | Trigonometric functions | Quotients"></q>
<q index1="|A.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q07S.C4.01" qid="Q07S.C4.01" des="Also simplification of rational expression" index7="15.1 | 15.1a | 15.1b" marks="5 marks" time="6" ttext="Remainder theorem"></q>
<q index1="|H.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q07S.C4.02" qid="Q07S.C4.02" des=" -1 power; simple PFs; expansion validity" index7="15.1d | 15.3a" marks="12 marks" time="14" ttext="Binomial expansion"></q>
<q index1="|J|J.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q07S.C4.03" qid="Q07S.C4.03" des="Rcos(x-a); assoc eqn and minimum value" index7="15.4 | 15.4a" marks="10 marks" time="12" ttext="Trigonometry | Sum or diff of 2 angles"></q>
<q index1="|F.D$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q07S.C4.04" qid="Q07S.C4.04" des="Eqn interp and expo to ln ; rate of change" index7="15.5" marks="11 marks" time="13" ttext="Exponential functions"></q>
<q index1="|D.A.G$|D.A.J|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q07S.C4.05" qid="Q07S.C4.05" des="Differentiation involving x^2.y^2" index7="15.6c" marks="10 marks" time="12" ttext="Implicit functions | Quotients"></q>
<q index1="|D.A.H$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q07S.C4.06" qid="Q07S.C4.06" des="Grad with trig parameter; cartesian conversion " index7="15.2 | 15.6c" marks="8 marks" time="10" ttext="Parametric equations"></q>
<q index1="|C|C.A$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q07S.C4.07" qid="Q07S.C4.07" des="Perpendicularity/intersection proofs; line length" index7="15.7b | 15.7c" marks="11 marks" time="13" ttext="Vectors | Equations of lines"></q>
<q index1="|P.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q07S.C4.08" qid="Q07S.C4.08" des="Std with boundary cond; some alg manip" index7="15.6b" marks="8 marks" time="10" ttext="Variable separable"></q>
<q index1="|M$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q07S.P1.01" qid="Q07S.P1.01" des="Scalar mult/subtraction; comb of transforms" index7="16.8" marks="6 marks" time="7" ttext="Matrices"></q>
<q index1="|K$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q07S.P1.02" qid="Q07S.P1.02" des="Verifying root interval; interval bisection twice" index7="16.6 | 16.6a" marks="7 marks" time="8" ttext="Numerical methods"></q>
<q index1="|L|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q07S.P1.03" qid="Q07S.P1.03" des="Conj; real/imaginary parts; soln simult eqns" index7="16.2" marks="6 marks" time="7" ttext="Complex Numbers"></q>
<q index1="|A.F$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q07S.P1.04" qid="Q07S.P1.04" des="Symmetric fn algebra; eqn with given roots" index7="16.3" marks="7 marks" time="8" ttext="Roots of quadratic"></q>
<q index1="|F.G$|K$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q07S.P1.05" qid="Q07S.P1.05" des="Based on y = a(b^x); mainly numerical work" index7="16.6 | 16.6c" marks="11 marks" time="13" ttext="Reduction to linear law | Numerical methods"></q>
<q index1="|J|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q07S.P1.06" qid="Q07S.P1.06" des="Genl soln trig eqn; knowledge of sin (pi/3)" index7="16.7" marks="6 marks" time="7" ttext="Trigonometry"></q>
<q index1="|F.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q07S.P1.07" qid="Q07S.P1.07" des="Asymptotes; sketch; assoc inequality" index7="16.1 | 16.1a" marks="9 marks" time="11" ttext="Rational functions"></q>
<q index1="|D.B|I.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q07S.P1.08" qid="Q07S.P1.08" des="Simple improper integrals" index7="16.5b" marks="8 marks" time="10" ttext="Integration | Improper integrals"></q>
<q index1="|B.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q07S.P1.09" qid="Q07S.P1.09" des="Ellipse; translation effect; tangency condition" index7="16.1d" marks="15 marks" time="18" ttext="Conic sections"></q>
<q index1="|I.A$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q07S.P2.01" qid="Q07S.P2.01" des="Using method of differences" index7="17.5" marks="7 marks" time="8" ttext="Finite series"></q>
<q index1="|A.G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q07S.P2.02" qid="Q07S.P2.02" des="Cubic equation (coeffs real); complex roots" index7="17.1 | 17.2 | 17.2a" marks="12 marks" time="14" ttext="Roots of polynomials"></q>
<q index1="|L.C$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q07S.P2.03" qid="Q07S.P2.03" des="Integer power; solve cos 15x = 0; sin 15x = -1" index7="17.3a" marks="5 marks" time="6" ttext="De Moivre's Theorem"></q>
<q index1="|D.A|D.A.F$|D.A.I$|D.B|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q07S.P2.04" qid="Q07S.P2.04" des="Diff prod involving inv tan; 'reverse' diff" index7="17.6" marks="7 marks" time="8" ttext="Differentiation | Inverse trig functions | Product | Integration"></q>
<q index1="|L|L.B$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q07S.P2.05" qid="Q07S.P2.05" des="Arg diag; loci perp bisector and equal args" index7="17.2 | 17.2b" marks="9 marks" time="11" ttext="Complex Numbers | Loci"></q>
<q index1="|E$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q07S.P2.06" qid="Q07S.P2.06" des="Induction proof concerning a product" index7="17.4" marks="7 marks" time="8" ttext="Proof by induction"></q>
<q index1="|D.B|D.C$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q07S.P2.07" qid="Q07S.P2.07" des="Arc length; subst leading to integral cosh^2 (x)" index7="17.7 | 17.8" marks="15 marks" time="18" ttext="Integration | Arc Length and Area of Surf. Revol"></q>
<q index1="|L.C$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q07S.P2.08" qid="Q07S.P2.08" des="Solve z^n= a+ib; knowledge exp(ix)+exp(-ix)" index7="17.3 | 17.3c" marks="13 marks" time="15" ttext="De Moivre's Theorem"></q>
<q index1="|P.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q07S.P3.01" qid="Q07S.P3.01" des="Equal roots AE; CF/PI both contain e^5x; hint " index7="18.5 | 18.5a | 18.5b" marks="10 marks" time="12" ttext="Differential Equations - 2nd order"></q>
<q index1="|P|P.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q07S.P3.02" qid="Q07S.P3.02" des="Euler and Improved Euler formulae" index7="18.4 | 18.4c" marks="9 marks" time="11" ttext="Differential equations | Differential equations - 1st order"></q>
<q index1="|P.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q07S.P3.03" qid="Q07S.P3.03" des="Standard integrating factor" index7="18.4 | 18.4a" marks="8 marks" time="10" ttext="Differential equations - 1st order"></q>
<q index1="|O|O.A$|O.B$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q07S.P3.04" qid="Q07S.P3.04" des="Cartesian to polar; area of loop" index7="18.2 | 18.2a | 18.2b" marks="14 marks" time="17" ttext="Polar co-ordinates | Cartesian equations | Areas"></q>
<q index1="|P.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q07S.P3.05" qid="Q07S.P3.05" des="Subst giving 1st order DE variables separable" index7="18.5 | 18.5c" marks="12 marks" time="14" ttext="Differential Equations - 2nd order"></q>
<q index1="|I.E$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q07S.P3.06" qid="Q07S.P3.06" des="Std Maclaurin; final part involves limiting form" index7="18.1 | 18.1a | 18.1b" marks="15 marks" time="18" ttext="Maclaurin series"></q>
<q index1="|D.B|I.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q07S.P3.07" qid="Q07S.P3.07" des="Involving limits and integration by subst" index7="18.1b | 18.1c" marks="7 marks" time="8" ttext="Integration | Improper integrals"></q>
<q index1="|C|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q07S.P4.01" qid="Q07S.P4.01" des="Involving vector product and sc tr prod" index7="19.1a | 19.1b" marks="6 marks" time="7" ttext="Vectors"></q>
<q index1="|N|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q07S.P4.02" qid="Q07S.P4.02" des="Factorisation of 3X3 determinant" index7="19.4" marks="6 marks" time="7" ttext="Determinants"></q>
<q index1="|C|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q07S.P4.03" qid="Q07S.P4.03" des="Sc tr prod; triangle area using vector product" index7="19.1 | 19.1a | 19.1b | 19.1c" marks="8 marks" time="10" ttext="Vectors"></q>
<q index1="|N|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q07S.P4.04" qid="Q07S.P4.04" des="Linear eqns; non-unique soln; inconsistency" index7="19.3 | 19.4" marks="13 marks" time="16" ttext="Determinants"></q>
<q index1="|C|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q07S.P4.05" qid="Q07S.P4.05" des="Line eqn; dir cosines; plane eqn; normal vector" index7="19.1 | 19.1c | 19.1d" marks="16 marks" time="19" ttext="Vectors"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q07S.P4.06" qid="Q07S.P4.06" des="Matrix alg; matrix transforms(enlarge/rotate)" index7="19.2a | 19.2c" marks="12 marks" time="14" ttext="Matrices"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q07S.P4.07" qid="Q07S.P4.07" des="Characteristic eqn; eigenvalues/eigenvectors" index7="19.2a | 19.2d" marks="14 marks" time="17" ttext="Matrices"></q>
<q index1="|A.I$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q06W.C1.01" qid="Q06W.C1.01" des="Addition and multiplication of surds" index7="12.1a" marks="4 marks" time="5" ttext="Surds/indices"></q>
<q index1="|B.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q06W.C1.02" qid="Q06W.C1.02" des="Gradient; perpendicular lines; eqn of line" index7="12.2a" marks="10 marks" time="12" ttext="Straight lines"></q>
<q index1="|A.C$|A.E$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q06W.C1.03" qid="Q06W.C1.03" des="Linear and quadratic" index7="12.1c" marks="9 marks" time="11" ttext="Completing the square | Simultaneous equations"></q>
<q index1="|A.E$|A.F$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q06W.C1.04" qid="Q06W.C1.04" des="Use of discriminant" index7="12.1b" marks="5 marks" time="6" ttext="Simultaneous equations | Roots of quadratic"></q>
<q index1="|A.C$|B.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q06W.C1.05" qid="Q06W.C1.05" des="Eqn given; point inside or outside circle?" index7="12.2b" marks="9 marks" time="11" ttext="Completing the square | Circle"></q>
<q index1="|A.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q06W.C1.06" qid="Q06W.C1.06" des="Includes sketching a cubic graph" index7="12.1e | 12.1f" marks="9 marks" time="11" ttext="Factor theorem"></q>
<q index1="|D.A.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q06W.C1.07" qid="Q06W.C1.07" des="Use 2nd derivative to identify max/min" index7="12.3a | 12.3b | 12.3c" marks="11 marks" time="13" ttext="Polynomials"></q>
<q index1="|A.D$|D.A.A$|D.B.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q06W.C1.08" qid="Q06W.C1.08" des="Area under curve; eqn tgt; inc/dec function" index7="12.1d | 12.2c | 12.3a | 12.3b | 12.4a | 12.4b" marks="18 marks" time="22" ttext="Inequalities | Polynomials | Integration of polynomials"></q>
<q index1="|D.A.B$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q06W.C2.01" qid="Q06W.C2.01" des="Test of basics" index7="13.5" marks="5 marks" time="6" ttext="Non-integer powers of x"></q>
<q index1="|K$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q06W.C2.02" qid="Q06W.C2.02" des="Trapezium rule" index7="13.6b" marks="5 marks" time="6" ttext="Numerical methods"></q>
<q index1="|D.A.D$|F.D$|H.B$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q06W.C2.03" qid="Q06W.C2.03" des="Soln of a^x=b. Infinite GP" index7="13.2c | 13.4b" marks="9 marks" time="11" ttext="Exponential functions (differentiation) | Exponential functions | Geometric series"></q>
<q index1="|J.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q06W.C2.04" qid="Q06W.C2.04" des="Includes use of area of triangle; cosine rule" index7="13.3a | 13.3b" marks="11 marks" time="13" ttext="Arc length/area of sectors/segments"></q>
<q index1="|H|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q06W.C2.05" qid="Q06W.C2.05" des="Includes finding the limiting value" index7="13.2a" marks="9 marks" time="11" ttext="Sequences and series"></q>
<q index1="|A.H$|J|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q06W.C2.06" qid="Q06W.C2.06" des="Includes soln of sin(x-a)=b; use of identities" index7="13.1b | 13.3c | 13.3d" marks="13 marks" time="16" ttext="Transformation of graphs | Trigonometry"></q>
<q index1="|F.E$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q06W.C2.07" qid="Q06W.C2.07" des="Laws of logarithms" index7="13.4a" marks="5 marks" time="6" ttext="Logarithmic function"></q>
<q index1="|D.A.B$|D.B.B$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q06W.C2.08" qid="Q06W.C2.08" des="Eqn tgt; area between curve and lines" index7="13.5 | 13.6a" marks="18 marks" time="22" ttext="Non-integer powers of x | Integration of non-integer powers of x"></q>
<q index1="|D.A.C$|D.A.J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q06W.C3.01" qid="Q06W.C3.01" des="Including use of chain rule" index7="14.4a | 14.4b" marks="5 marks" time="6" ttext="Trigonometric functions | Quotients"></q>
<q index1="|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q06W.C3.02" qid="Q06W.C3.02" des="Simpson's rule" index7="14.6c" marks="4 marks" time="5" ttext="Numerical methods"></q>
<q index1="|D.A.A$|D.B.D$|D.B.G|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q06W.C3.03" qid="Q06W.C3.03" des="Standard application of basic knowledge" index7="14.4a | 14.4b | 14.5b" marks="10 marks" time="12" ttext="Polynomials | Integration by substitution | Spot integrals"></q>
<q index1="|J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q06W.C3.04" qid="Q06W.C3.04" des="Soln of eqn in cot x and cosec^2 x" index7="14.2b | 14.2c" marks="7 marks" time="8" ttext="Trigonometry"></q>
<q index1="|D.B.C$|F.F$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q06W.C3.05" qid="Q06W.C3.05" des="Includes vol of rev" index7="14.1b | 14.4a | 14.4b | 14.5c" marks="12 marks" time="14" ttext="Integration of exponential functions | Modulus function"></q>
<q index1="|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q06W.C3.06" qid="Q06W.C3.06" des="Loc of roots; iteration; cobweb/staircase diag" index7="14.6a | 14.6b" marks="9 marks" time="11" ttext="Numerical methods"></q>
<q index1="|A.H$|J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q06W.C3.07" qid="Q06W.C3.07" des="Inverse trig function" index7="14.1c | 14.2a" marks="5 marks" time="6" ttext="Transformation of graphs | Trigonometry"></q>
<q index1="|F.A$|F.B$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q06W.C3.08" qid="Q06W.C3.08" des="Well structured question" index7="14.1a" marks="10 marks" time="12" ttext="Range/domain | Inverse functions"></q>
<q index1="|D.A.E$|D.A.I$|D.B.E$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q06W.C3.09" qid="Q06W.C3.09" des="Includes stat pts and area under curve" index7="14.4a | 14.4b | 14.5b" marks="13 marks" time="16" ttext="Logarithmic functions (differentiation) | Product | Integration by parts"></q>
<q index1="|A.A$|A.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q06W.C4.01" qid="Q06W.C4.01" des="Simplification of rational expression" index7="15.1a | 15.1b" marks="8 marks" time="10" ttext="Factor theorem | Remainder theorem"></q>
<q index1="|D.A.H$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q06W.C4.02" qid="Q06W.C4.02" des="Eqn of tangent; Cartesian eqn of curve" index7="15.2" marks="11 marks" time="13" ttext="Parametric equations"></q>
<q index1="|J|J.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q06W.C4.03" qid="Q06W.C4.03" des="Rcos(x+a); maximum value of the function" index7="15.4a" marks="6 marks" time="7" ttext="Trigonometry | Sum or diff of 2 angles"></q>
<q index1="|D.A.D$|F.D$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q06W.C4.04" qid="Q06W.C4.04" des="Exponential growth and decay" index7="15.5" marks="9 marks" time="11" ttext="Exponential functions (differentiation) | Exponential functions"></q>
<q index1="|H.C$|I.D$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q06W.C4.05" qid="Q06W.C4.05" des="Expansion of rational function" index7="15.3a | 15.3b" marks="15 marks" time="18" ttext="Binomial expansion | Use of partial fractions"></q>
<q index1="|J.A$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q06W.C4.06" qid="Q06W.C4.06" des="cos^2 x" index7="15.4b" marks="7 marks" time="8" ttext="Double angle"></q>
<q index1="|C.A$|C.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q06W.C4.07" qid="Q06W.C4.07" des="Includes angles between two lines" index7="15.7a | 15.7b | 15.7c" marks="10 marks" time="12" ttext="Equations of lines | Scalar product"></q>
<q index1="|P.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q06W.C4.08" qid="Q06W.C4.08" des="Modelling with eqn given" index7="15.6b" marks="9 marks" time="11" ttext="Variable separable"></q>
<q index1="|K$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q06W.P1.01" qid="Q06W.P1.01" des="Cubic eqn; location of roots; linear interp" index7="16.6a" marks="5 marks" time="6" ttext="Numerical methods"></q>
<q index1="|I.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q06W.P1.02" qid="Q06W.P1.02" des="Std question on application of basic work" index7="16.5b" marks="7 marks" time="8" ttext="Improper integrals"></q>
<q index1="|J|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q06W.P1.03" qid="Q06W.P1.03" des="General soln of trig equation" index7="16.7" marks="5 marks" time="6" ttext="Trigonometry"></q>
<q index1="|F.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q06W.P1.04" qid="Q06W.P1.04" des="Curve sketching and soln of inequality" index7="16.1a | 16.1b" marks="10 marks" time="12" ttext="Rational functions"></q>
<q index1="|A.F$|L.A$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q06W.P1.05" qid="Q06W.P1.05" des="Includes complex conjugate" index7="16.2 | 16.3" marks="11 marks" time="13" ttext="Roots of quadratic | Use of x + iy"></q>
<q index1="|K$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q06W.P1.06" qid="Q06W.P1.06" des="Exponential curve; reduction to linear eqn" index7="16.6c" marks="11 marks" time="13" ttext="Numerical methods"></q>
<q index1="|M$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q06W.P1.07" qid="Q06W.P1.07" des="Transformation and matrix algebra" index7="16.8" marks="11 marks" time="13" ttext="Matrices"></q>
<q index1="|B.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q06W.P1.08" qid="Q06W.P1.08" des="Parabola; transform/eqn tgt using equal roots" index7="16.1d" marks="15 marks" time="18" ttext="Conic sections"></q>
<q index1="|I.A$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q06W.P2.01" qid="Q06W.P2.01" des="Difference method" index7="17.5" marks="6 marks" time="7" ttext="Finite series"></q>
<q index1="|A.G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q06W.P2.02" qid="Q06W.P2.02" des="Cubic eqn; one root is a complex number" index7="17.1" marks="10 marks" time="12" ttext="Roots of polynomials"></q>
<q index1="|L.C$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q06W.P2.03" qid="Q06W.P2.03" des="Modulus; De M's/Arg diag to find tan(angle)" index7="17.2b | 17.3a | 17.3b | 17.3c" marks="12 marks" time="14" ttext="De Moivre's Theorem"></q>
<q index1="|I.A$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q06W.P2.04" qid="Q06W.P2.04" des="Proof by induction; sum series from n+1 to 2n" index7="17.4 | 17.5" marks="9 marks" time="11" ttext="Finite series"></q>
<q index1="|L.B$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q06W.P2.05" qid="Q06W.P2.05" des="Well structured question" index7="17.2b" marks="9 marks" time="11" ttext="Loci"></q>
<q index1="|L.C$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q06W.P2.06" qid="Q06W.P2.06" des="Includes the soln of a quartic eqn" index7="17.3a" marks="12 marks" time="14" ttext="De Moivre's Theorem"></q>
<q index1="|G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q06W.P2.07" qid="Q06W.P2.07" des="Use of identities; differentiation/arc length" index7="17.7" marks="17 marks" time="20" ttext="Hyperbolic functions"></q>
<q index1="|P.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q06W.P3.01" qid="Q06W.P3.01" des="Aux eqn; genl soln/use of initial conditions" index7="18.5a" marks="12 marks" time="14" ttext="Differential Equations - 2nd order"></q>
<q index1="|D.B.E$|I.B$|I.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q06W.P3.02" qid="Q06W.P3.02" des="Involves exponential function" index7="18.1b | 18.1c" marks="8 marks" time="10" ttext="Integration by parts | Infinite series | Improper integrals"></q>
<q index1="|P.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q06W.P3.03" qid="Q06W.P3.03" des="Use of PI" index7="18.4a" marks="8 marks" time="10" ttext="Differential equations - 1st order"></q>
<q index1="|I.B$|I.E$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q06W.P3.04" qid="Q06W.P3.04" des="Rational function involving expo; log/trig fns" index7="18.1a | 18.1b | 18.1d" marks="14 marks" time="17" ttext="Infinite series | Maclaurin series"></q>
<q index1="|K$|P.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q06W.P3.05" qid="Q06W.P3.05" des="Euler formula; analytic soln using int factor" index7="18.4a | 18.4b" marks="17 marks" time="20" ttext="Numerical methods | Differential equations - 1st order"></q>
<q index1="|O.A$|O.B$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q06W.P3.06" qid="Q06W.P3.06" des="Cartesian/polar; intersection of 2 polar curves" index7="18.2a | 18.2b" marks="16 marks" time="19" ttext="Cartesian equations | Areas"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q06W.P4.01" qid="Q06W.P4.01" des="3X3 matrix; geometrical transformation" index7="19.2c" marks="3 marks" time="4" ttext="Matrices"></q>
<q index1="|M$|N.A$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q06W.P4.02" qid="Q06W.P4.02" des="Matrix algebra" index7="19.2a | 19.4" marks="7 marks" time="8" ttext="Matrices | Evaluate determinants"></q>
<q index1="|C.A$|C.B$|C.D$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q06W.P4.03" qid="Q06W.P4.03" des="Intersection of line/plane; not std line eqn" index7="19.1a | 19.1c | 19.1d" marks="10 marks" time="12" ttext="Equations of lines | Equations of planes | Vector product"></q>
<q index1="|C.D$|Q$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q06W.P4.04" qid="Q06W.P4.04" des="Includes geometric relationship btwn vectors" index7="19.1a" marks="10 marks" time="12" ttext="Vector product | Linear independence"></q>
<q index1="|M$|N.A$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q06W.P4.05" qid="Q06W.P4.05" des="Cartes eqn line invar pts;geom description" index7="19.2b" marks="12 marks" time="14" ttext="Matrices | Evaluate determinants"></q>
<q index1="|N.B$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q06W.P4.06" qid="Q06W.P4.06" des="Factorise 3X3 det; eqns consistent/inconsist" index7="19.3 | 19.4" marks="14 marks" time="17" ttext="Use and solving equations"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q06W.P4.07" qid="Q06W.P4.07" des="Eigenvectors/values; will test the most able" index7="19.2d" marks="19 marks" time="23" ttext="Matrices"></q>
<q index1="|A.E$|B.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q06S.C1.01" qid="Q06S.C1.01" des="Eqn of line; pt of intersection; perp lines" index7="12.2a" marks="10 marks" time="12" ttext="Simultaneous equations | Straight lines"></q>
<q index1="|A.C$|A.H$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q06S.C1.02" qid="Q06S.C1.02" des="Sketch quad graph/locate min point" index7="12.1f" marks="10 marks" time="12" ttext="Completing the square | Transformation of graphs"></q>
<q index1="|D.A.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q06S.C1.03" qid="Q06S.C1.03" des="Eqn of tgt; increasing/decreasing function" index7="12.2 | 12.2c | 12.3a | 12.3b" marks="7 marks" time="8" ttext="Polynomials"></q>
<q index1="|A.I$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q06S.C1.04" qid="Q06S.C1.04" des="Product and quotient" index7="12.1a" marks="6 marks" time="7" ttext="Surds/indices"></q>
<q index1="|D.A.A$|D.B.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q06S.C1.05" qid="Q06S.C1.05" des="Stationary points; area under curve" index7="12.3a | 12.3b | 12.4a | 12.4b" marks="15 marks" time="18" ttext="Polynomials | Integration of polynomials"></q>
<q index1="|A.A$|A.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q06S.C1.06" qid="Q06S.C1.06" des="Includes algebraic division" index7="12.1e" marks="10 marks" time="12" ttext="Factor theorem | Remainder theorem"></q>
<q index1="|A.C$|A.E$|A.F$|B.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q06S.C1.07" qid="Q06S.C1.07" des="Dist from centre onto chord; use of discrim" index7="12.1b | 12.2b" marks="17 marks" time="20" ttext="Completing the square | Simultaneous equations | Roots of quadratic | Circle"></q>
<q index1="|J.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q06S.C2.01" qid="Q06S.C2.01" des="Test of basic knowledge" index7="13.3b" marks="5 marks" time="6" ttext="Arc length/area of sectors/segments"></q>
<q index1="|J|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q06S.C2.02" qid="Q06S.C2.02" des="Use of sine rule; area of triangle" index7="13.3a" marks="6 marks" time="7" ttext="Trigonometry"></q>
<q index1="|A.F$|H.A$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q06S.C2.03" qid="Q06S.C2.03" des="Sum given find number of terms" index7="13.2b" marks="7 marks" time="8" ttext="Roots of quadratic | Arithmetic series"></q>
<q index1="|H.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q06S.C2.04" qid="Q06S.C2.04" des="(1-ax)^n" index7="13.2d" marks="8 marks" time="10" ttext="Binomial expansion"></q>
<q index1="|F.E$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q06S.C2.05" qid="Q06S.C2.05" des="Laws of logs" index7="13.4a" marks="6 marks" time="7" ttext="Logarithmic function"></q>
<q index1="|A.H$|D.A.D$|F.D$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q06S.C2.06" qid="Q06S.C2.06" des="Includes soln of a^x=b" index7="13.1b | 13.4b" marks="15 marks" time="18" ttext="Transformation of graphs | Exponential functions (differentiation) | Exponential functions"></q>
<q index1="|D.A.B$|D.B.B$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q06S.C2.07" qid="Q06S.C2.07" des="Includes use of 2nd deriv; find eqn of curve" index7="13.5 | 13.6a" marks="17 marks" time="20" ttext="Non-integer powers of x | Integration of non-integer powers of x"></q>
<q index1="|A.H$|J|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q06S.C2.08" qid="Q06S.C2.08" des="Soln of trig eqn involving sinx and cosx" index7="13.3c | 13.3d" marks="11 marks" time="13" ttext="Transformation of graphs | Trigonometry"></q>
<q index1="|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q06S.C3.01" qid="Q06S.C3.01" des="Use of iteration in solving eqn" index7="14.6a | 14.6b" marks="6 marks" time="7" ttext="Numerical methods"></q>
<q index1="|D.B.D$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q06S.C3.02" qid="Q06S.C3.02" des="Use of chain rule" index7="14.4b | 14.5b" marks="6 marks" time="7" ttext="Integration by substitution"></q>
<q index1="|J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q06S.C3.03" qid="Q06S.C3.03" des="Eqn includes secx and tanx" index7="14.2b | 14.2c" marks="9 marks" time="11" ttext="Trigonometry"></q>
<q index1="|F.F$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q06S.C3.04" qid="Q06S.C3.04" des="Use of sketch to solve eqn and inequality" index7="14.1b" marks="8 marks" time="10" ttext="Modulus function"></q>
<q index1="|D.A.D$|F.D$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q06S.C3.05" qid="Q06S.C3.05" des="Use of 2nd deriv to identify nature of stat pts" index7="14.3a | 14.3b | 14.4a" marks="13 marks" time="16" ttext="Exponential functions (differentiation) | Exponential functions"></q>
<q index1="|D.A.E$|D.A.I$|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q06S.C3.06" qid="Q06S.C3.06" des="Includes use of mid-ordinate rule" index7="14.4a | 14.6c" marks="9 marks" time="11" ttext="Logarithmic functions (differentiation) | Product | Numerical methods"></q>
<q index1="|D.A.J|D.B.G|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q06S.C3.07" qid="Q06S.C3.07" des="Includes vol of rev" index7="14.4a | 14.4b | 14.5c" marks="8 marks" time="10" ttext="Quotients | Spot integrals"></q>
<q index1="|D.A.E$|F.A$|F.B$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q06S.C3.08" qid="Q06S.C3.08" des="Well structured question" index7="14.1a" marks="9 marks" time="11" ttext="Logarithmic functions (differentiation) | Range/domain | Inverse functions"></q>
<q index1="|D.A.C$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q06S.C3.09" qid="Q06S.C3.09" des="Diff of inverse trig function" index7="14.2a | 14.4a" marks="7 marks" time="8" ttext="Trigonometric functions"></q>
<q index1="|A.A$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q06S.C4.01" qid="Q06S.C4.01" des="Includes simplification of rational expression" index7="15.1a | 15.1b" marks="8 marks" time="10" ttext="Factor theorem"></q>
<q index1="|H.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q06S.C4.02" qid="Q06S.C4.02" des="Includes range of values for which exp is valid" index7="15.3a" marks="8 marks" time="10" ttext="Binomial expansion"></q>
<q index1="|D.B.F$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q06S.C4.03" qid="Q06S.C4.03" des="x^2 in both num and denom" index7="15.6d" marks="8 marks" time="10" ttext="Integration using partial fractions"></q>
<q index1="|J|J.A$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q06S.C4.04" qid="Q06S.C4.04" des="Soln of trig eqn" index7="15.4b" marks="9 marks" time="11" ttext="Trigonometry | Double angle"></q>
<q index1="|D.A.G$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q06S.C4.05" qid="Q06S.C4.05" des="Includes stationary points" index7="15.6c" marks="14 marks" time="17" ttext="Implicit functions"></q>
<q index1="|C.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q06S.C4.06" qid="Q06S.C4.06" des="Geom of vectors; variation on perp vectors" index7="15.7a" marks="12 marks" time="14" ttext="Scalar product"></q>
<q index1="|P.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q06S.C4.07" qid="Q06S.C4.07" des="Test of basics" index7="15.6b" marks="6 marks" time="7" ttext="Variable separable"></q>
<q index1="|P|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q06S.C4.08" qid="Q06S.C4.08" des="Modelling; forming diff eqn; soln of eqn given" index7="15.6a" marks="10 marks" time="12" ttext="Differential equations"></q>
<q index1="|A.F$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q06S.P1.01" qid="Q06S.P1.01" des="Find eqn with roots a^3 and b^3" index7="16.3" marks="9 marks" time="11" ttext="Roots of quadratic"></q>
<q index1="|K$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q06S.P1.02" qid="Q06S.P1.02" des="Step-by-step method" index7="16.6b" marks="6 marks" time="7" ttext="Numerical methods"></q>
<q index1="|I.A$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q06S.P1.03" qid="Q06S.P1.03" des="Use of sigma r^2" index7="16.4" marks="4 marks" time="5" ttext="Finite series"></q>
<q index1="|J|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q06S.P1.04" qid="Q06S.P1.04" des="General soln" index7="16.7" marks="5 marks" time="6" ttext="Trigonometry"></q>
<q index1="|M$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q06S.P1.05" qid="Q06S.P1.05" des="Matrix algebra and transformation" index7="16.8" marks="9 marks" time="11" ttext="Matrices"></q>
<q index1="|L.A$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q06S.P1.06" qid="Q06S.P1.06" des="Use of complex conjugate" index7="16.2" marks="7 marks" time="8" ttext="Use of x + iy"></q>
<q index1="|B.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q06S.P1.07" qid="Q06S.P1.07" des="Transformation of hyperbola" index7="16.1d" marks="6 marks" time="7" ttext="Conic sections"></q>
<q index1="|K$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q06S.P1.08" qid="Q06S.P1.08" des="Grad of curve as lim(grad chord); N-Raphson" index7="16.5McLean | 16.5b" marks="13 marks" time="16" ttext="Numerical methods"></q>
<q index1="|F.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q06S.P1.09" qid="Q06S.P1.09" des="Asymptotes/stat points; curve sketching" index7="16.1a | 16.1c" marks="16 marks" time="19" ttext="Rational functions"></q>
<q index1="|I.A$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q06S.P2.01" qid="Q06S.P2.01" des="Difference method" index7="17.5" marks="7 marks" time="8" ttext="Finite series"></q>
<q index1="|D.A.H$|D.C$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q06S.P2.02" qid="Q06S.P2.02" des="Surface area" index7="17.8" marks="8 marks" time="10" ttext="Parametric equations | Arc Length and Area of Surf. Revol"></q>
<q index1="|G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q06S.P2.03" qid="Q06S.P2.03" des="Intersection of curve and line; stat points" index7="17.7" marks="15 marks" time="18" ttext="Hyperbolic functions"></q>
<q index1="|L.B$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q06S.P2.04" qid="Q06S.P2.04" des="Involves inequalities" index7="17.2b" marks="7 marks" time="8" ttext="Loci"></q>
<q index1="|A.G$|L|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q06S.P2.05" qid="Q06S.P2.05" des="Cubic with complex numbers as coeft" index7="17.1 | 17.2a | 17.2b" marks="13 marks" time="16" ttext="Roots of polynomials | Complex Numbers"></q>
<q index1="|E$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q06S.P2.06" qid="Q06S.P2.06" des="f(x) divisible by 7" index7="17.4" marks="8 marks" time="10" ttext="Proof by induction"></q>
<q index1="|L.C$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q06S.P2.07" qid="Q06S.P2.07" des="Well structured and testing in parts" index7="17.3b" marks="17 marks" time="20" ttext="De Moivre's Theorem"></q>
<q index1="|P.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q06S.P3.01" qid="Q06S.P3.01" des="Particular integral; initial conditions given" index7="18.5a | 18.5b" marks="11 marks" time="13" ttext="Differential Equations - 2nd order"></q>
<q index1="|K$|P|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q06S.P3.02" qid="Q06S.P3.02" des="Including improved Euler formula" index7="18.4b" marks="9 marks" time="11" ttext="Numerical methods | Differential equations"></q>
<q index1="|P.A$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q06S.P3.03" qid="Q06S.P3.03" des="Use of integrating factor" index7="18.4a" marks="9 marks" time="11" ttext="Differential equations - 1st order"></q>
<q index1="|O.A$|O.B$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q06S.P3.04" qid="Q06S.P3.04" des="Intersection of polar curve and circle" index7="18.2a | 18.2b" marks="12 marks" time="14" ttext="Cartesian equations | Areas"></q>
<q index1="|I.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q06S.P3.05" qid="Q06S.P3.05" des="Standard question" index7="18.1b | 18.1c" marks="7 marks" time="8" ttext="Improper integrals"></q>
<q index1="|P.C$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q06S.P3.06" qid="Q06S.P3.06" des="Use of substitution" index7="18.5c" marks="14 marks" time="17" ttext="Differential Equations - 2nd order"></q>
<q index1="|I.B$|I.E$|" index2="|7$|" index3="" index4="" index5="|2$|" index6="Q06S.P3.07" qid="Q06S.P3.07" des="Expansion of sec x and tan x" index7="18.1a | 18.1b" marks="13 marks" time="16" ttext="Infinite series | Maclaurin series"></q>
<q index1="|C.A$|C.B$|C.C$|C.D$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q06S.P4.01" qid="Q06S.P4.01" des="Angle betwn/eqn line intersection of 2 planes" index7="19.1a | 19.1c" marks="8 marks" time="10" ttext="Equations of lines | Equations of planes | Scalar product | Vector product"></q>
<q index1="|N.A$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q06S.P4.02" qid="Q06S.P4.02" des="Invariant line; geometrical interpretation" index7="19.4" marks="5 marks" time="6" ttext="Evaluate determinants"></q>
<q index1="|N.A$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q06S.P4.03" qid="Q06S.P4.03" des="Factorise" index7="19.4" marks="6 marks" time="7" ttext="Evaluate determinants"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q06S.P4.04" qid="Q06S.P4.04" des="Line of invariant points" index7="19.2c" marks="6 marks" time="7" ttext="Matrices"></q>
<q index1="|A.E$|N.A$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q06S.P4.05" qid="Q06S.P4.05" des="Geometrical interpretation of solns" index7="19.3 | 19.4" marks="12 marks" time="14" ttext="Simultaneous equations | Evaluate determinants"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q06S.P4.06" qid="Q06S.P4.06" des="Singular matrix; inverse of 3X3; transformation" index7="19.2a | 19.2c" marks="10 marks" time="12" ttext="Matrices"></q>
<q index1="|C.B$|C.C$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q06S.P4.07" qid="Q06S.P4.07" des="Lin depend vectors; 2 forms of eqn of planes" index7="19.1 | 19.1c | 19.5" marks="14 marks" time="17" ttext="Equations of planes | Scalar product"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q06S.P4.08" qid="Q06S.P4.08" des="Algebraic qn involving eigenvectors/values" index7="19.2d" marks="14 marks" time="17" ttext="Matrices"></q>
<q index1="|A.E$|B.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q05W.C1.01" qid="Q05W.C1.01" des="Well structured and standard question" index7="12.1c | 12.2a" marks="7 marks" time="8" ttext="Simultaneous equations | Straight lines"></q>
<q index1="|D.A.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q05W.C1.02" qid="Q05W.C1.02" des="Eqn of normal and inc/dec function" index7="12.2c | 12.3a | 12.3b" marks="10 marks" time="12" ttext="Polynomials"></q>
<q index1="|A.E$|B.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q05W.C1.03" qid="Q05W.C1.03" des="Std question on circles/line of intersection" index7="12.2b | 12.2d" marks="11 marks" time="13" ttext="Simultaneous equations | Circle"></q>
<q index1="|A.B$|D.B.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q05W.C1.04" qid="Q05W.C1.04" des="Well structured and standard question" index7="12.1e | 12.4a | 12.4b" marks="15 marks" time="18" ttext="Remainder theorem | Integration of polynomials"></q>
<q index1="|A.I$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q05W.C1.05" qid="Q05W.C1.05" des="Product and quotient" index7="12.1a" marks="7 marks" time="8" ttext="Surds/indices"></q>
<q index1="|D.A.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q05W.C1.06" qid="Q05W.C1.06" des="Max/min vol of rectangular box" index7="12.3b | 12.3c" marks="15 marks" time="18" ttext="Polynomials"></q>
<q index1="|A.D$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q05W.C1.07" qid="Q05W.C1.07" des="Real roots of quadratic /discriminant" index7="12.1b" marks="10 marks" time="12" ttext="Inequalities"></q>
<q index1="|D.A.B$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q05W.C2.01" qid="Q05W.C2.01" des="Leading to equation of normal to a curve" index7="12.2c | 13.5" marks="8 marks" time="10" ttext="Non-integer powers of x"></q>
<q index1="|J.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q05W.C2.02" qid="Q05W.C2.02" des="Use of cosine rule or right angled triangle" index7="13.3a | 13.3b" marks="10 marks" time="12" ttext="Arc length/area of sectors/segments"></q>
<q index1="|H.A$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q05W.C2.03" qid="Q05W.C2.03" des="Includes use of sigma notation" index7="13.2b" marks="8 marks" time="10" ttext="Arithmetic series"></q>
<q index1="|A.I$|D.B.B$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q05W.C2.04" qid="Q05W.C2.04" des="Well structured leading to def. integral/surds" index7="13.1a | 13.6a" marks="9 marks" time="11" ttext="Surds/indices | Integration of non-integer powers of x"></q>
<q index1="|F.E$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q05W.C2.05" qid="Q05W.C2.05" des="Laws of logs; logs to base 4" index7="13.4a" marks="7 marks" time="8" ttext="Logarithmic function"></q>
<q index1="|D.A.A$|H.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q05W.C2.06" qid="Q05W.C2.06" des="Leading to stationary points" index7="12.3a | 12.3b | 13.2d" marks="10 marks" time="12" ttext="Polynomials | Binomial expansion"></q>
<q index1="|A.H$|J|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q05W.C2.07" qid="Q05W.C2.07" des="Leading to solving cos 2x = 0.37" index7="13.1b" marks="11 marks" time="13" ttext="Transformation of graphs | Trigonometry"></q>
<q index1="|D.A.D$|F.D$|K$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q05W.C2.08" qid="Q05W.C2.08" des="Trap rule under/over estimate; soln of a^x=b" index7="13.4 | 13.4b | 13.6b" marks="12 marks" time="14" ttext="Exponential functions (differentiation) | Exponential functions | Numerical methods"></q>
<q index1="|A.F$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q05W.P1.01" qid="Q05W.P1.01" des="Standard question" index7="16.3" marks="7 marks" time="8" ttext="Roots of quadratic"></q>
<q index1="|B.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q05W.P1.02" qid="Q05W.P1.02" des="Ellipse translated" index7="16.1d" marks="8 marks" time="10" ttext="Conic sections"></q>
<q index1="|L.A$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q05W.P1.03" qid="Q05W.P1.03" des="Use of complex conjugate" index7="16.2" marks="6 marks" time="7" ttext="Use of x + iy"></q>
<q index1="|I.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q05W.P1.04" qid="Q05W.P1.04" des="Standard question" index7="16.5b" marks="7 marks" time="8" ttext="Improper integrals"></q>
<q index1="|M$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q05W.P1.05" qid="Q05W.P1.05" des="Transformations" index7="16.8" marks="8 marks" time="10" ttext="Matrices"></q>
<q index1="|J|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q05W.P1.06" qid="Q05W.P1.06" des="General soln" index7="16.7" marks="8 marks" time="10" ttext="Trigonometry"></q>
<q index1="|F.G$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q05W.P1.07" qid="Q05W.P1.07" des="y^3 and x^2" index7="16.6c" marks="8 marks" time="10" ttext="Reduction to linear law"></q>
<q index1="|K$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q05W.P1.08" qid="Q05W.P1.08" des="Newton-Raphson" index7="16.6a" marks="9 marks" time="11" ttext="Numerical methods"></q>
<q index1="|F.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q05W.P1.09" qid="Q05W.P1.09" des="Asymptotes and stationary points" index7="16.1a" marks="14 marks" time="17" ttext="Rational functions"></q>
<q index1="|A.E$|B.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q05S.C1.01" qid="Q05S.C1.01" des="Length; mid-pt; grad; intersection of lines" index7="12.2a" marks="12 marks" time="14" ttext="Simultaneous equations | Straight lines"></q>
<q index1="|A.C$|A.H$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q05S.C1.02" qid="Q05S.C1.02" des="Vertex of quadratic function" index7="12.1f" marks="10 marks" time="10" ttext="Completing the square | Transformation of graphs"></q>
<q index1="|B.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q05S.C1.03" qid="Q05S.C1.03" des="Centre and radius given; eqn of tangent" index7="12.2b | 12.2c" marks="10 marks" time="12" ttext="Circle"></q>
<q index1="|A.A$|D.A.A$|D.B.A$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q05S.C1.04" qid="Q05S.C1.04" des="Well structured question" index7="12.3a | 12.3b | 12.3c | 12.4a | 12.4b" marks="18 marks" time="22" ttext="Factor theorem | Polynomials | Integration of polynomials"></q>
<q index1="|A.I$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q05S.C1.05" qid="Q05S.C1.05" des="Squaring and quotient of surds" index7="12.1a" marks="5 marks" time="6" ttext="Surds/indices"></q>
<q index1="|A.B$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q05S.C1.06" qid="Q05S.C1.06" des="Leading to real root of cubic eqn" index7="12.1b | 12.1e" marks="7 marks" time="8" ttext="Remainder theorem"></q>
<q index1="|A.D$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q05S.C1.07" qid="Q05S.C1.07" des="One linear; one quadratic" index7="12.1d" marks="7 marks" time="8" ttext="Inequalities"></q>
<q index1="|A.E$|" index2="|1$|" index3="" index4="" index5="|1$|" index6="Q05S.C1.08" qid="Q05S.C1.08" des="Use of discriminant to find equal roots" index7="12.1b | 12.1c" marks="6 marks" time="7" ttext="Simultaneous equations"></q>
<q index1="|J|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q05S.C2.01" qid="Q05S.C2.01" des="Area of triangle; cosine rule" index7="13.3a" marks="5 marks" time="6" ttext="Trigonometry"></q>
<q index1="|J.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q05S.C2.02" qid="Q05S.C2.02" des="Standard question" index7="13.3b" marks="5 marks" time="6" ttext="Arc length/area of sectors/segments"></q>
<q index1="|H.A$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q05S.C2.03" qid="Q05S.C2.03" des="Includes the use of sigma notation" index7="13.2b" marks="6 marks" time="7" ttext="Arithmetic series"></q>
<q index1="|A.H$|D.A.B$|D.B.B$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q05S.C2.04" qid="Q05S.C2.04" des="Includes the use of trapezium rule" index7="13.1b | 13.6a | 13.6b" marks="19 marks" time="23" ttext="Transformation of graphs | Non-integer powers of x | Integration of non-integer powers of x"></q>
<q index1="|H.B$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q05S.C2.05" qid="Q05S.C2.05" des="Sum to infinity; will test more able students" index7="13.2c" marks="12 marks" time="14" ttext="Geometric series"></q>
<q index1="|A.I$|H.C$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q05S.C2.06" qid="Q05S.C2.06" des="Includes logs to base 2" index7="13.2d | 13.4a" marks="9 marks" time="11" ttext="Surds/indices | Binomial expansion"></q>
<q index1="|A.I$|D.A.B$|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q05S.C2.07" qid="Q05S.C2.07" des="Includes normal to curve; increasing fn" index7="12.2c | 12.3b | 13.5" marks="9 marks" time="11" ttext="Surds/indices | Non-integer powers of x"></q>
<q index1="|J|" index2="|2$|" index3="" index4="" index5="|1$|" index6="Q05S.C2.08" qid="Q05S.C2.08" des="Trig eqn that reduces to a quad in cos x" index7="13.3d" marks="10 marks" time="12" ttext="Trigonometry"></q>
<q index1="|D.A.I$|D.B.G|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q05S.C3.01" qid="Q05S.C3.01" des="Includes use of chain rule" index7="14.4b" marks="8 marks" time="10" ttext="Product | Spot integrals"></q>
<q index1="|F.A$|F.B$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q05S.C3.02" qid="Q05S.C3.02" des="Includes composite functions" index7="14.1a" marks="6 marks" time="7" ttext="Range/domain | Inverse functions"></q>
<q index1="|D.B.C$|D.B.D$|D.B.E$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q05S.C3.03" qid="Q05S.C3.03" des="Standard questions" index7="14.5b" marks="8 marks" time="10" ttext="Integration of exponential functions | Integration by substitution | Integration by parts"></q>
<q index1="|J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q05S.C3.04" qid="Q05S.C3.04" des="Quadratic in sec x" index7="14.2b | 14.2c" marks="8 marks" time="10" ttext="Trigonometry"></q>
<q index1="|D.A.D$|F.D$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q05S.C3.05" qid="Q05S.C3.05" des="Use of substitution to solve eqn in e^x" index7="14.3a | 14.3b" marks="7 marks" time="8" ttext="Exponential functions (differentiation) | Exponential functions"></q>
<q index1="|D.B.A$|F.F$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q05S.C3.06" qid="Q05S.C3.06" des="Vol of rev; soln of eqn and inequality" index7="14.1b | 14.5c" marks="13 marks" time="16" ttext="Integration of polynomials | Modulus function"></q>
<q index1="|F.B$|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q05S.C3.07" qid="Q05S.C3.07" des="Use of iterative method to solve eqn" index7="14.2a | 14.6b" marks="9 marks" time="11" ttext="Inverse functions | Numerical methods"></q>
<q index1="|A.H$|D.B.C$|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q05S.C3.08" qid="Q05S.C3.08" des="Including use of mid-ordinate rule" index7="14.1c | 14.3 | 14.3a | 14.5a | 14.6c" marks="16 marks" time="19" ttext="Transformation of graphs | Integration of exponential functions | Numerical methods"></q>
<q index1="|J|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q05S.C4.01" qid="Q05S.C4.01" des="Use of Rsin(x+a)" index7="15.4a" marks="7 marks" time="8" ttext="Trigonometry"></q>
<q index1="|D.B.F$|I.D$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q05S.C4.02" qid="Q05S.C4.02" des="Standard question" index7="15.1d | 15.6d" marks="6 marks" time="7" ttext="Integration using partial fractions | Use of partial fractions"></q>
<q index1="|A.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q05S.C4.03" qid="Q05S.C4.03" des="Simplification of rational expression" index7="15.1a | 15.1b" marks="6 marks" time="7" ttext="Remainder theorem"></q>
<q index1="|H.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q05S.C4.04" qid="Q05S.C4.04" des="(1+x)^ neg fraction" index7="15.3a" marks="8 marks" time="10" ttext="Binomial expansion"></q>
<q index1="|D.A.H$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q05S.C4.05" qid="Q05S.C4.05" des="Parametric to Cartesian" index7="15.2" marks="10 marks" time="12" ttext="Parametric equations"></q>
<q index1="|J.A$|J.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q05S.C4.06" qid="Q05S.C4.06" des="Leading to integration of cos^3 x" index7="15.4a | 15.4b" marks="12 marks" time="14" ttext="Double angle | Sum or diff of 2 angles"></q>
<q index1="|C.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q05S.C4.07" qid="Q05S.C4.07" des="Use of sc prod to find foot of perpendicular" index7="15.7c" marks="12 marks" time="14" ttext="Scalar product"></q>
<q index1="|D.A.D$|F.D$|P.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q05S.C4.08" qid="Q05S.C4.08" des="Exponential decay" index7="15.5 | 15.6b" marks="14 marks" time="17" ttext="Exponential functions (differentiation) | Exponential functions | Variable separable"></q>
<q index1="|M$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q05S.P1.01" qid="Q05S.P1.01" des="Matrix algebra" index7="16.8" marks="6 marks" time="7" ttext="Matrices"></q>
<q index1="|K$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q05S.P1.02" qid="Q05S.P1.02" des="Diff eqn; step-by-step method" index7="16.6b" marks="6 marks" time="7" ttext="Numerical methods"></q>
<q index1="|I.A$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q05S.P1.03" qid="Q05S.P1.03" des="Use of sigma r^3 and r^2" index7="16.4" marks="7 marks" time="8" ttext="Finite series"></q>
<q index1="|K$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q05S.P1.04" qid="Q05S.P1.04" des="Gradient as limit of chord" index7="16.5McLean" marks="7 marks" time="8" ttext="Numerical methods"></q>
<q index1="|J|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q05S.P1.05" qid="Q05S.P1.05" des="General soln" index7="16.7" marks="7 marks" time="8" ttext="Trigonometry"></q>
<q index1="|A.F$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q05S.P1.06" qid="Q05S.P1.06" des="Includes the use of complex numbers" index7="16.2 | 16.3" marks="11 marks" time="13" ttext="Roots of quadratic"></q>
<q index1="|M$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q05S.P1.07" qid="Q05S.P1.07" des="Transformation of a triangle" index7="16.8" marks="10 marks" time="12" ttext="Matrices"></q>
<q index1="|B.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q05S.P1.08" qid="Q05S.P1.08" des="Will challenge the most able" index7="16.1d" marks="8 marks" time="10" ttext="Conic sections"></q>
<q index1="|F.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q05S.P1.09" qid="Q05S.P1.09" des="Asymptotes and stationary points" index7="16.1a" marks="13 marks" time="16" ttext="Rational functions"></q>
<q index1="|A.E$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q05S.P4.01" qid="Q05S.P4.01" des="Standard question on soln of linear eqns" index7="19.3" marks="4 marks" time="5" ttext="Simultaneous equations"></q>
<q index1="|C.A$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q05S.P4.02" qid="Q05S.P4.02" des="Cartesian eqn of line; direction cosines" index7="19.1d" marks="5 marks" time="6" ttext="Equations of lines"></q>
<q index1="|N.A$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q05S.P4.03" qid="Q05S.P4.03" des="3X3 determinant; volume of images" index7="19.4" marks="6 marks" time="7" ttext="Evaluate determinants"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q05S.P4.04" qid="Q05S.P4.04" des="3 X 3 ; determ of product; axis/rotation angle" index7="19.2a | 19.2c" marks="8 marks" time="10" ttext="Matrices"></q>
<q index1="|C.B$|C.C$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q05S.P4.05" qid="Q05S.P4.05" des="Includes angle between line and plane" index7="19.1c" marks="10 marks" time="12" ttext="Equations of planes | Scalar product"></q>
<q index1="|Q$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q05S.P4.06" qid="Q05S.P4.06" des="Sc tr prod; linearly dependent vectors" index7="19.1b" marks="10 marks" time="12" ttext="Linear independence"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q05S.P4.07" qid="Q05S.P4.07" des="2X2 matrix; line of invariant points" index7="19.2b" marks="7 marks" time="8" ttext="Matrices"></q>
<q index1="|N.A$|N.B$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q05S.P4.08" qid="Q05S.P4.08" des="3X3 determinant; unique soln of eqns" index7="19.3 | 19.4" marks="10 marks" time="12" ttext="Evaluate determinants | Use and solving equations"></q>
<q index1="|M$|" index2="|8$|" index3="" index4="" index5="|2$|" index6="Q05S.P4.09" qid="Q05S.P4.09" des="2X2 matrix; eigenvalues/vectors; v.challenging" index7="19.2d" marks="15 marks" time="18" ttext="Matrices"></q>
</root>
EOXML
objectives = Nokogiri::Slop <<-EOXML
<root>
<level1 id="" data="ALL>
<level1 id="12" data="Pure Core 1">
<level1 id="12.1" data="Algebra">
<level1 id="12.1a" data="Use and manipulation of surds"></level1>
<level1 id="12.1b" data="Quad functions and discriminants"></level1>
<level1 id="12.1c" data="Simultaneous eq inc quadractic eq "></level1>
<level1 id="12.1d" data="Linear/quadratic inequalities"></level1>
<level1 id="12.1e" data="Polys/Factor/Remainder Theorem "></level1>
<level1 id="12.1f" data="Curve sketching and geom interpretation"></level1>
</level1>
<level1 id="12.2" data="Co-ordinate geometry">
<level1 id="12.2a" data="Straight lines"></level1>
<level1 id="12.2b" data="Circle"></level1>
<level1 id="12.2c" data="Tangent/normal"></level1>
<level1 id="12.2d" data="Intersection of straight line and curve"></level1>
</level1>
<level1 id="12.3" data="Differentiation">
<level1 id="12.3a" data="Differentiation of polynomials"></level1>
<level1 id="12.3b" data="Apps of diff/max and min/inc and dec fns"></level1>
<level1 id="12.3c" data="Second order derivatives"></level1>
</level1>
<level1 id="12.4" data="Integration">
<level1 id="12.4a" data="Integration of polynomials"></level1>
<level1 id="12.4b" data="Area under a curve/def integrals"></level1>
</level1>
</level1>
<level1 id="13" data="Pure Core 2">
<level1 id="13.1" data="Algebra and Functions">
<level1 id="13.1a" data="Laws of indices"></level1>
<level1 id="13.1b" data="Transformations of graphs"></level1>
</level1>
<level1 id="13.2" data="Sequences and Series">
<level1 id="13.2a" data="Sequences"></level1>
<level1 id="13.2b" data="Arithmetic series"></level1>
<level1 id="13.2c" data="Geometric series"></level1>
<level1 id="13.2d" data="Binomial expansion"></level1>
</level1>
<level1 id="13.3" data="Trigonometry">
<level1 id="13.3a" data="Sine and cosine rules/area of triangle"></level1>
<level1 id="13.3b" data="Arc length and area of sector"></level1>
<level1 id="13.3c" data="Sin/cos/tan graphs and identities"></level1>
<level1 id="13.3d" data="Simple trigonometric equations"></level1>
</level1>
<level1 id="13.4" data="Exponentials and Logarithms">
<level1 id="13.4a" data="Laws of logarithms"></level1>
<level1 id="13.4b" data="Equation: a^x = b"></level1>
</level1>
<level1 id="13.5" data="Differentiation of non integer powers"></level1>
<level1 id="13.6" data="Integration">
<level1 id="13.6a" data="Integration of non integer powers of x"></level1>
<level1 id="13.6b" data="Trapezium rule"></level1>
</level1>
</level1>
<level1 id="14" data="Pure Core 3">
<level1 id="14.1" data="Algebra and Functions">
<level1 id="14.1a" data="Domain/range; composition; inverse fns"></level1>
<level1 id="14.1b" data="The modulus function"></level1>
<level1 id="14.1c" data="Combinations of transformations"></level1>
</level1>
<level1 id="14.2" data="Trigonometry">
<level1 id="14.2a" data="Inverse trig functions"></level1>
<level1 id="14.2b" data="Sec/cosec/cot"></level1>
<level1 id="14.2c" data="Knowledge and use of identities"></level1>
</level1>
<level1 id="14.3" data="Exponentials and Logarithms">
<level1 id="14.3a" data="e^x and its graphs"></level1>
<level1 id="14.3b" data="ln x and its graph"></level1>
</level1>
<level1 id="14.4" data="Differentiation">
<level1 id="14.4a" data="Diff of e^x, ln x, sin x, cos x, tan x"></level1>
<level1 id="14.4b" data="Product/quotient/chain rules"></level1>
</level1>
<level1 id="14.5" data="Integration">
<level1 id="14.5a" data="Integration of e^x, 1/x, sin x, cos x"></level1>
<level1 id="14.5b" data="Int by substitution/parts/std integrals"></level1>
<level1 id="14.5c" data="Volume of revolution"></level1>
</level1>
<level1 id="14.6" data="Numerical Methods">
<level1 id="14.6a" data="Location of roots"></level1>
<level1 id="14.6b" data="Iterative methods"></level1>
<level1 id="14.6c" data="Mid-ordinate and Simpson's rule"></level1>
</level1>
</level1>
<level1 id="15" data="Pure Core 4">
<level1 id="15.1" data="Algebra and Functions">
<level1 id="15.1a" data="Factor and remainder theorem"></level1>
<level1 id="15.1b" data="Simplification of rational expressions"></level1>
<level1 id="15.1c" data="Algebraic division"></level1>
<level1 id="15.1d" data="Partial fractions"></level1>
</level1>
<level1 id="15.2" data="Coordinate Geometry (x, y) plane"></level1>
<level1 id="15.3" data="Sequences and Series">
<level1 id="15.3a" data="Binomial series"></level1>
<level1 id="15.3b" data="Series expansion of rational functions"></level1>
</level1>
<level1 id="15.4" data="Trigonometry">
<level1 id="15.4a" data="Use of addition formulae"></level1>
<level1 id="15.4b" data="Double angle formulae "></level1>
</level1>
<level1 id="15.5" data="Exponentials and logarithms"></level1>
<level1 id="15.6" data="Differentiation and Integration">
<level1 id="15.6a" data="Formation of simple differential eq"></level1>
<level1 id="15.6b" data="Diff equations/separable variables"></level1>
<level1 id="15.6c" data="Differentiation implicit/parametric"></level1>
<level1 id="15.6d" data="Integration using partial fractions"></level1>
</level1>
<level1 id="15.7" data="Vectors">
<level1 id="15.7a" data="Geometry of vectors"></level1>
<level1 id="15.7b" data="Vector equations of lines"></level1>
<level1 id="15.7c" data="Scalar product and applications"></level1>
</level1>
</level1>
<level1 id="16" data="Further Pure 1">
<level1 id="16.1" data="Algebra and Graphs">
<level1 id="16.1a" data="Rational functions"></level1>
<level1 id="16.1b" data="Inequalities with rational functions"></level1>
<level1 id="16.1c" data="Quadratic theory to find max and min"></level1>
<level1 id="16.1d" data="Parabolas/ellipses/hyperbolas"></level1>
</level1>
<level1 id="16.2" data="Complex numbers"></level1>
<level1 id="16.3" data="Roots and Coefficients of Quad Eqns"></level1>
<level1 id="16.4" data="Series"></level1>
<level1 id="16.5" data="Calculus">
<level1 id="16.5McLean" data="Grad of curve as limit of grad of chord"></level1>
<level1 id="16.5b" data="Simple improper integrals"></level1>
</level1>
<level1 id="16.6" data="Numerical Methods">
<level1 id="16.6a" data="Bisection/lin interp/N-Raphson"></level1>
<level1 id="16.6b" data="Step-by-step method"></level1>
<level1 id="16.6c" data="Reducing to linear law"></level1>
</level1>
<level1 id="16.7" data="Trigonometry"></level1>
<level1 id="16.8" data="Matrices and Transformations"></level1>
</level1>
<level1 id="17" data="Further Pure 2">
<level1 id="17.1" data="Roots of Polynomials"></level1>
<level1 id="17.2" data="Complex Numbers">
<level1 id="17.2a" data="Representation and algebra"></level1>
<level1 id="17.2b" data="Argand diagram and simple loci"></level1>
</level1>
<level1 id="17.3" data="De Moivre's Theorem">
<level1 id="17.3a" data="De Moivre's theorem for integral n"></level1>
<level1 id="17.3b" data="De Moivre's/the nth roots of unity"></level1>
<level1 id="17.3c" data="Solutions of equation z^n = a + ib"></level1>
</level1>
<level1 id="17.4" data="Proof by induction"></level1>
<level1 id="17.5" data="Finite series"></level1>
<level1 id="17.6" data="Calculus of inverse trig funcs"></level1>
<level1 id="17.7" data="Hyperbolic functions"></level1>
<level1 id="17.8" data="Arc length and area of surface of revoltn"></level1>
</level1>
<level1 id="18" data="Further Pure 3">
<level1 id="18.1" data="Series and Limits">
<level1 id="18.1a" data="Maclaurin series"></level1>
<level1 id="18.1b" data="Knowledge and use of limits"></level1>
<level1 id="18.1c" data="Evaluation of improper integrals"></level1>
<level1 id="18.1d" data="Use of exp, ln and trig expansions"></level1>
</level1>
<level1 id="18.2" data="Polar Coordinates">
<level1 id="18.2a" data="Polar and cartesian co-ordinates"></level1>
<level1 id="18.2b" data="Area formula"></level1>
</level1>
<level1 id="18.3" data="Differential equation concept"></level1>
<level1 id="18.4" data="Differential Equations - 1st order">
<level1 id="18.4a" data="Solution of 1st order linear diff eq"></level1>
<level1 id="18.4b" data="Numerical methods for solving diff eq"></level1>
<level1 id="18.4c" data="Euler's formula"></level1>
</level1>
<level1 id="18.5" data="Differential Equations - 2nd order">
<level1 id="18.5a" data="Use of auxiliary equation"></level1>
<level1 id="18.5b" data="Complementary fn and particular integral"></level1>
<level1 id="18.5c" data="Reduction to a pair of 1st order DEs"></level1>
</level1>
</level1>
<level1 id="19" data="Further Pure 4">
<level1 id="19.1" data="Vector and 3-D Coordinate Geometry">
<level1 id="19.1a" data="Vector product"></level1>
<level1 id="19.1b" data="Scalar triple product"></level1>
<level1 id="19.1c" data="Application of vectors to 2/3 D geometry"></level1>
<level1 id="19.1d" data="Cartesian equation of lines and planes"></level1>
</level1>
<level1 id="19.2" data="Matrix algebra">
<level1 id="19.2a" data="Matrix algebra"></level1>
<level1 id="19.2b" data="Matrix transformations in 2 D"></level1>
<level1 id="19.2c" data="Matrix transformations in 3 D"></level1>
<level1 id="19.2d" data="Eigenvalues and eigenvectors"></level1>
</level1>
<level1 id="19.3" data="Solution of Linear Equations"></level1>
<level1 id="19.4" data="Determinants"></level1>
<level1 id="19.5" data="Linear Independence"></level1>
</level1>
</root>
EOXML


    testpaper = TestPaper.find(params[:testpaper_id])
    url = params[:test_paper_url]
    
    params =  CGI::parse(url)
    questions =  params["doclist"].join.split("|").compact
    questions.sort_by!{ |m| m.downcase }
    questions.each_with_index do |question, index|
      if question_meta_data.root.q.at_css("[qid='#{question}']") != nil then
        template_url = url.scan(/.*?(?=doclist)doclist/).join
        q_url = url.gsub(/doclist\s*(((?!doclist|&).)+)/, "doclist=#{urlify(question)}")
        question_html = Nokogiri::HTML(open(q_url))
        m_url = q_url.gsub(/type.?\=[A-Z]/, "type=M")
        mark_scheme_html = Nokogiri::HTML(open(m_url))

        mainquestion = MainQuestion.create(
            exampro_id: question,
            test_paper_id: testpaper.id,
            answer_html: mark_scheme_html.to_html,
            html: question_html.to_html
            )
        testpaper.main_questions << mainquestion
        testpaper.save
        marks = question_html.content.scan(/\(\d\)/)
    
        if question_html.css("table")
        question_html.css("table").each_with_index do |table, index|
          ques_id = table.content.scan(/\([a-h]\)|\(i\)|\(ii\)|\(iii\)|\(iv\)|\(v\)/).join()
          if ques_id.scan(/\(i\)|\(ii\)|\(iii\)|\(iv\)|\(v\)/).size > 1 then # validation
          else
            begin
              if ques_id.strip.scan(/^(\(i\)|\(ii\)|\(iii\)|\(iv\)|\(v\))/).size < 1 then #checks if q_id != just (i)|(ii)...
                $last_good = ques_id.scan(/\([a-h]\)/).join
                ques = Question.new(
                  main_question_id: mainquestion.id,
                  total_marks: marks[index].scan(/[0-50]/).join.to_i,
                  html: table.to_html,
                  position: ques_id,
                  )
                ques.save

              else
                Question.create(
                  main_question_id: mainquestion.id,
                  total_marks: marks[index].scan(/[0-50]/).join.to_i,
                  html: table.to_html,
                  position: "#{$last_good}#{ques_id}"
                  )
              end
            rescue NoMethodError

            end
            end
          end

        end
        question_objectives_ids = question_meta_data.root.q.at_css("[qid='#{question}']").attribute("index7").to_s.split("| ") # find objective ids
        question_objectives_ids.each do |o_id| 
          unless objectives.root.level1.css("[id='#{o_id.sub(/[a-z]/, "")}']") == nil then
            topic = Topic.find_or_create_by( name: objectives.root.level1.at_css("[id='#{o_id.strip.sub(/[a-z]/, "")}']").attribute("data").to_html.scan(/".*?"/).join.gsub(/\"/, ""), subject: testpaper.subject )
          end
          objective = Objective.find_or_create_by(
                name: objectives.root.css("[id='#{o_id.strip}']").attribute("data").to_html.scan(/".*?"/).join.gsub(/\"/, ""),
                topic: topic,
                )
          
          mainquestion.objectives << objective
          mainquestion.save
          objective.main_questions << mainquestion
          objective.save

        end
      end
      
    end
    redirect_to test_paper_path(testpaper)
  end
  def show_uploaded
    @questions = Question.last(params[:questions_number])
  end
  def show
    @main_questions = @test_paper.main_questions
    @main_questions.each do |mainquestion|
      if mainquestion.questions.count == 0 then

                Question.create(
                    main_question_id: mainquestion.id,
                    total_marks: mainquestion.html.scan(/Total ./).join.sub("Total ", ""),
                    html: mainquestion.html,
                    position: "#{mainquestion.html.scan(/Q\d\./)}"
                    )
      end
    end
  end

  def new
    @test_paper = TestPaper.new
    @question = Question.new
  end

  def edit
  end

  def create
    @test_paper = TestPaper.new(test_paper_params)
    @test_paper.save
    redirect_to test_paper_path(@test_paper)
  end

  def update
    @test_paper.update(test_paper_params)
    redirect_to @test_paper
  end

  def destroy
    @test_paper.destroy
    redirect_to :back
  end

  private
    def set_test_paper
      @test_paper = TestPaper.find(params[:id])
    end

    def test_paper_params
      params.require(:test_paper).permit(:subject_id,:name, :testpaper_id , :test_paper_url, :html, :mark_scheme_html, :source, :exam_notes_html, :description,  :questions, :date, :calc_allowed, :url, questions_attributes: [:text, :attachment, :total_marks, lines_attributes: [ :id, :question_id, :objective_id, :_destroy ]])
    end

    def number_of_questions(url)
      g = 0
      test = []
      objects = []
      page = Nokogiri::HTML(open(url))
      page.css("table").each_with_index do |object, index|
        if is_start_of(object)  then
          objects.push index
        end
      end
      return objects.count
    end

    def is_start_of(table)
      type = "question"
      unless table.css("b") == nil then
        a = table.css("b").to_a
        objects = []
        a.each do |x|
          if /#{parse_type(type)}[1-9]\./.match(x.content) != nil then 
            objects.push(x)
          end
        end
        if objects.count > 0 then
         return true
        else return false
        end
      else
        return false
      end
    end

    def parse_type(type)
      case type
      when "question", "a question", "questions"
        type = "Q"
      when "marking" , "answer" , "markings" , "answers"
        type = "M"
      when "exam note", "exam notes" , "exam_note"
        type = "E"
      when "note" , "info"
        type = "N"
      else 
        raise "invalid type in parse_types"
      end
      return type
    end 

end