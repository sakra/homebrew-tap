require "formula"

class H5edit < Formula
  desc "tool for editing HDF5 files"
  homepage "https://support.hdfgroup.org/projects/jpss/h5edit_index.html"
  url "http://www.hdfgroup.org/ftp/HDF5/projects/jpss/h5edit/h5edit-1.3.1.tar.gz"
  sha256 "57e2cc7cd67af82614e51064ee969ffa0a5328b8c58c4ed7085db32a8d99acef"

  depends_on 'hdf5'

  # fix compilation problem
  patch :DATA

  def install
    ENV['CC'] = "#{HOMEBREW_PREFIX}/bin/h5cc"
    ENV['CXX'] = "#{HOMEBREW_PREFIX}/bin/h5c++"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end

end

__END__
diff --git a/src/misc.c b/src/misc.c
index c72874a..c119e50 100644
--- a/src/misc.c
+++ b/src/misc.c
@@ -238,9 +238,9 @@ usage(void)
  * H5Fopen it.
  * Return 0 succeess, otherwise -1.
  */
-int opendatafile(const char *name)
+hid_t opendatafile(const char *name)
 {
-    int ret_code=0;
+    hid_t ret_code=0;
     hid_t fapl = H5P_DEFAULT;

     /* setup to use backup VFD if atomic is choosen */
