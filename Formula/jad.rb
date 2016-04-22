require 'formula'

class JadDownloadStrategy < CurlDownloadStrategy
  def stage
    # the JAD tarball contains odd parent directory references, which unzip does not handle by default
    # -j -d forces all files to be extracted in the directory 'JAD'
    safe_system '/usr/bin/unzip', '-j', '-d', 'JAD', @tarball_path
    chdir
  end
end

class Jad < Formula
  homepage 'http://www.varaneckas.com/jad/'
  url 'http://www.varaneckas.com/jad/jad158g.mac.intel.zip', :using  => JadDownloadStrategy
  sha1 '25bf73676eec21d4cf02f110cb7a06d37cb52f16'
  version '1.5.8g'

  def install
    bin.install 'jad'
    man1.install 'jad.1'
    doc.install 'Readme.txt'
  end

end
