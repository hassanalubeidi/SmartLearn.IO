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
<q index1="|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q10S.C3.01" qid="Q10S.C3.01" des="Iterative process involves location/manip" index7="14.6a | 14.6b" marks="5 marks" time="6" ttext="Numerical methods"> </q>
<q index1="|A.H$|F.F$|J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q10S.C3.02" qid="Q10S.C3.02" des="Sec x; tests modulus/solves 2 assoc eqns" index7="14.1b | 14.1c | 14.2b" marks="10 marks" time="12" ttext="Transformation of graphs | Modulus function | Trigonometry"> </q>
<q index1="|D.A|D.A.C$|D.A.E$|F|F.A$|F.B$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q10S.C3.03" qid="Q10S.C3.03" des="2-part; ln/trig derivs; ln/trig fns/comp/inv" index7="14.1a | 14.2a | 14.4a" marks="12 marks" time="14" ttext="Differentiation | Trigonometric functions | Logarithmic functions (differentiation) | Functions | Range/domain | Inverse functions"> </q>
<q index1="|D.B|K$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q10S.C3.04" qid="Q10S.C3.04" des="2-part; std Simpson's rule; def integral f '/f" index7="14.5a | 14.6 | 14.6c" marks="8 marks" time="10" ttext="Integration | Numerical methods"> </q>
<q index1="|J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q10S.C3.05" qid="Q10S.C3.05" des="cosec^2 = 1+cot^2 to prod/solve quad(cot x)" index7="14.2b | 14.2c" marks="5 marks" time="6" ttext="Trigonometry"> </q>
<q index1="|D.A|D.A.E$|D.A.J|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q10S.C3.06" qid="Q10S.C3.06" des="y=ln x/x; find stat pt/grad normal at specific pt" index7="14.4a | 14.4b" marks="9 marks" time="11" ttext="Differentiation | Logarithmic functions (differentiation) | Quotients"> </q>
<q index1="|D.B.E$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q10S.C3.07" qid="Q10S.C3.07" des="3 connected items involving int by parts" index7="14.5a | 14.5b | 14.5c" marks="11 marks" time="13" ttext="Integration by parts"> </q>
<q index1="|A.F$|A.H$|D.B|D.B.C$|" index2="|3$|" index3="" index4="" index5="|2$|" index6="Q10S.C3.08" qid="Q10S.C3.08" des="Geom trans/quad exp(2x)/area btwn 2 curves" index7="14.1c | 14.3a | 14.5a" marks="15 marks" time="18" ttext="Roots of quadratic | Transformation of graphs | Integration | Integration of exponential functions"> </q>
<q index1="|A.A$|A.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q10S.C4.01" qid="Q10S.C4.01" des="Remainder/factor theorems to factorise cubic" index7="15.1a" marks="7 marks" time="8" ttext="Factor theorem | Remainder theorem"> </q>
<q index1="|B.B$|D.A|D.A.H$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q10S.C4.02" qid="Q10S.C4.02" des="Given param eqns;find eqn normal/cartes eqn" index7="15.2 | 15.6c" marks="9 marks" time="11" ttext="Straight lines | Differentiation | Parametric equations"> </q>
<q index1="|D.B.F$|F.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q10S.C4.03" qid="Q10S.C4.03" des="PFs to integrate rational fn/algebraic division" index7="15.1c | 15.1d | 15.6d" marks="8 marks" time="10" ttext="Integration using partial fractions | Rational functions"> </q>
<q index1="|H.C$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q10S.C4.04" qid="Q10S.C4.04" des="(1+x)^n extending to (16+9x)^n; num approx" index7="15.3a" marks="7 marks" time="8" ttext="Binomial expansion"> </q>
<q index1="|J.A$|J.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q10S.C4.05" qid="Q10S.C4.05" des="Use cos 2x and Rcos(x-a) to solve assoc eqns" index7="15.4a | 15.4b" marks="11 marks" time="13" ttext="Double angle | Sum or diff of 2 angles"> </q>
<q index1="|D.A|D.A.C$|D.A.G$|D.A.I$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q10S.C4.06" qid="Q10S.C4.06" des="Impl eqn; find grad/solve eqn involving cos(pi)" index7="15.6c" marks="7 marks" time="8" ttext="Differentiation | Trigonometric functions | Implicit functions | Product"> </q>
<q index1="|C|C.A$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q10S.C4.07" qid="Q10S.C4.07" des="Intersection of 2 lines; problem re parallel lines" index7="15.7 | 15.7a | 15.7b" marks="12 marks" time="14" ttext="Vectors | Equations of lines"> </q>
<q index1="|D.B.B$|P|P.A$|P.B$|" index2="|4$|" index3="" index4="" index5="|2$|" index6="Q10S.C4.08" qid="Q10S.C4.08" des="Simple DE/assoc pract prob; form DE/interpr" index7="15.6a | 15.6b" marks="14 marks" time="17" ttext="Integration of non-integer powers of x | Differential equations | Differential equations - 1st order | Variable separable"> </q>
<q index1="|K$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q10S.P1.01" qid="Q10S.P1.01" des="Standard step-by-step example" index7="16.6 | 16.6b" marks="6 marks" time="7" ttext="Numerical methods"> </q>
<q index1="|L|L.A$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q10S.P1.02" qid="Q10S.P1.02" des="Complex nos; mult/conjugate/real/imag" index7="16.2" marks="6 marks" time="7" ttext="Complex Numbers | Use of x + iy"> </q>
<q index1="|J|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q10S.P1.03" qid="Q10S.P1.03" des="General soln of cos(5x - a) = cos b" index7="16.7" marks="5 marks" time="6" ttext="Trigonometry"> </q>
<q index1="|K$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q10S.P1.04" qid="Q10S.P1.04" des="Linear law;graph to est values unknown consts" index7="16.6 | 16.6c" marks="8 marks" time="10" ttext="Numerical methods"> </q>
<q index1="|B.B$|D.A|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q10S.P1.05" qid="Q10S.P1.05" des="Grad line joining adjacent pts on curve/Limit" index7="16.5 | 16.5McLean" marks="6 marks" time="7" ttext="Straight lines | Differentiation"> </q>
<q index1="|M$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q10S.P1.06" qid="Q10S.P1.06" des="Describe transforms rep by various matrices" index7="16.8" marks="11 marks" time="13" ttext="Matrices"> </q>
<q index1="|F.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q10S.P1.07" qid="Q10S.P1.07" des="Find asym/int with axes/line; quad eqn/ineqn" index7="16.1 | 16.1a | 16.1b" marks="10 marks" time="12" ttext="Rational functions"> </q>
<q index1="|A.F$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q10S.P1.08" qid="Q10S.P1.08" des="Std manip roots quad eqn;form eqn w new roots" index7="16.3" marks="10 marks" time="12" ttext="Roots of quadratic"> </q>
<q index1="|A.E$|B.B$|B.C$|" index2="|5$|" index3="" index4="" index5="|1$|" index6="Q10S.P1.09" qid="Q10S.P1.09" des="Int of line/parabola; equal roots; tangency" index7="16.1 | 16.1d" marks="13 marks" time="16" ttext="Simultaneous equations | Straight lines | Conic sections"> </q>
<q index1="|F.D$|G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q10S.P2.01" qid="Q10S.P2.01" des="sinh and cosh expo formulae; soln quad exp(x)" index7="17.7" marks="9 marks" time="11" ttext="Exponential functions | Hyperbolic functions"> </q>
<q index1="|I.A$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q10S.P2.02" qid="Q10S.P2.02" des="Simple PFs; then method of differences" index7="17.5" marks="8 marks" time="10" ttext="Finite series"> </q>
<q index1="|L|L.B$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q10S.P2.03" qid="Q10S.P2.03" des="Arg diag loci; line bisector/arg; assoc ineqns" index7="17.2 | 17.2b" marks="9 marks" time="11" ttext="Complex Numbers | Loci"> </q>
<q index1="|A.G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q10S.P2.04" qid="Q10S.P2.04" des="Manip roots/cfs poly eqn; soln cubic " index7="17.1" marks="13 marks" time="16" ttext="Roots of polynomials"> </q>
<q index1="|D.A|D.C$|G$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q10S.P2.05" qid="Q10S.P2.05" des="Hyperbol forms (incl differentiation); arc length" index7="17.7 | 17.8" marks="18 marks" time="22" ttext="Differentiation | Arc Length and Area of Surf. Revol | Hyperbolic functions"> </q>
<q index1="|E$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q10S.P2.06" qid="Q10S.P2.06" des="Factorial simplification; std proof by induction " index7="17.4" marks="8 marks" time="10" ttext="Proof by induction"> </q>
<q index1="|L|L.C$|" index2="|6$|" index3="" index4="" index5="|2$|" index6="Q10S.P2.07" qid="Q10S.P2.07" des="Expo form of complex number; powers/roots" index7="17.3 | 17.3a | 17.3b | 17.3c" marks="10 marks" time="12" ttext="Complex Numbers | De Moivre's Theorem"> </q>
</root>
EOXML
objectives = Nokogiri::Slop <<-EOXML
<root>
<level1 id="" data="ALL"/>
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
      unless question_meta_data.root.q.at_css("[qid='#{question}']") == nil then
        template_url = "http://content.doublestruck.eu/?lk=b8a021269b01657fa73ed3cdcda2f530&subject=AA_MACO_D&headerdate=&headercomment=&returntype=1&headertitle=&headermarks=5&dl=false&headersubtitle=&headerauthor=&type=Q&doclist"
        q_url = "#{template_url}=%7C#{urlify(question)}"
        question_html = Nokogiri::HTML(open(q_url))

        mainquestion = MainQuestion.create(
            exampro_id: question,
            test_paper_id: testpaper.id
            )
        testpaper.main_questions << mainquestion
        testpaper.save
        marks = question_html.content.scan(/\(\d\)/)
    
        question_html.css("table").each_with_index do |table, index|
          ques_id = table.content.scan(/\([a-h]\)|\(i\)|\(ii\)|\(iii\)|\(iv\)|\(v\)/).join()
          if ques_id.scan(/\(i\)|\(ii\)|\(iii\)|\(iv\)|\(v\)/).size > 1 then # validation
             next
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
              rescue NoMethodError # you can also add this
                
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
        end
      end
      
    end
    redirect_to test_paper_path(testpaper)
  end
  def show_uploaded
    @questions = Question.last(params[:questions_number])
  end
  def show
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