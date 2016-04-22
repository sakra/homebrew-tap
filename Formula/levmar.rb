require 'formula'

class Levmar <Formula
  url 'http://www.ics.forth.gr/~lourakis/levmar/levmar-2.5.tgz'
  homepage 'http://www.ics.forth.gr/~lourakis/levmar/'
  md5 '7ca14d79eda6e985f8355b719ae47d35'

  depends_on 'clapack'

  def install
    clapack = Formula.factory('clapack')
    ENV.append "CFLAGS", "-I#{clapack.include}/clapack"
    ENV.append "LDFLAGS", "-L#{clapack.lib} -L."
    inreplace "Makefile" do |s|
      s.change_make_var! "CC", ENV['CC']
      s.change_make_var! 'CFLAGS', ENV['CFLAGS']
      s.change_make_var! 'LDFLAGS', ENV['LDFLAGS']
      s.change_make_var! 'LAPACKLIBS', '-lclapack -lcblas -lf2c'
    end
    system "make"
    (include + name).install Dir['*.h']
    lib.install "liblevmar.a"
  end
end
