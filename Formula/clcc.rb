require 'formula'

class ClccDownloadStrategy < CurlDownloadStrategy
  def stage
    # need to convert newlines or patch chokes
    safe_system '/usr/bin/unzip', '-aaqq', @tarball_path
    chdir
  end
end

class Clcc < Formula
  homepage 'http://clcc.sourceforge.net/'
  url 'http://sourceforge.net/projects/clcc/files/v0.3.0/clcc-0.3.0-25-src.zip',
      :using => ClccDownloadStrategy
  sha256 'df48fc1d66eb21c41de4eae2f68040a18c0818f8dbfa8071f011c19c538755d3'

  depends_on 'cmake' => :build
  depends_on 'boost'
  depends_on 'doxygen'

  def patches
    # fix CMake error upon configure generated (tarball is not an SVN work dir)
    DATA
  end

  def install
    system "cmake", ".", *std_cmake_args
    system "make"
    system "make clcc_doc"
    system "make install"
  end

end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 818dedf..22186ac 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -19,7 +19,7 @@ set(CLCC_VERSION_MINOR	3)
 set(CLCC_VERSION_PATCH	0)
 set(CLCC_VERSION_BUILD	0)	#	Undetermined, set by subversion (if present)
 
-find_package(Subversion)
+#find_package(Subversion)
 
 if (Subversion_FOUND)
 	Subversion_WC_INFO(${PROJECT_SOURCE_DIR} clcc)
