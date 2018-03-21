require 'formula'

class Stlsoft < Formula
  homepage 'http://www.stlsoft.org'
  url 'https://downloads.sourceforge.net/project/stlsoft/STLSoft%201.9/1.9.124/stlsoft-1.9.124-hdrs.zip'
  sha256 '1d4c8c475b164bab48bd7d4235dcaa35d4dfd012d77b397704ae539dbdc76dff'

  depends_on 'dos2unix' => :build

  def install
    system "/usr/bin/find . -type f -exec dos2unix --keepdate '{}' ';'"
    # put all includes into a directory of their own
    (include + "stlsoft").install Dir['include/*']
  end

end
