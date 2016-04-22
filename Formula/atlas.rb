require 'formula'

class Atlas <Formula
  url 'http://sourceforge.net/projects/math-atlas/files/Stable/3.10.0/atlas3.10.0.tar.bz2'
  homepage 'http://math-atlas.sourceforge.net/'
  sha1 '085e8219d01626485079b785309d4d6502ab1ac0'

  def patches
    # Makefile does not handle missing Fortran compiler correctly
    DATA
  end

  def options
    [
      ["--universal", "Build universal binaries."]
    ]
  end

  def install
    ENV.deparallelize
    ENV.universal_binary if ARGV.include? "--universal"
    mkdir "build"
    cd "build" do
      system "../configure", "--prefix=#{prefix}", "--nof77",
             "--cc=#{ENV.cc}", "--cflags=#{ENV.cflags}"
      system "make"
      system "make install"
    end
  end
end

__END__
