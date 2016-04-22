class Macstl < Formula
  homepage "http://www.pixelglow.com/macstl/"
  url "http://www.pixelglow.com/downloads/macstl-0.3.1.tgz"
  version "0.3.1"
  sha256 "c423384aa6430c7c36ad81a53b5f66b46f5c8e596a0e62216dfc8edf4bf64125"

  # fix C++ 11 compatibility and unsupported _mm_srai_epi64 intrinsic
  patch :DATA

  def install
    include.install "macstl"
  end

end

__END__
diff --git a/macstl/impl/vec_mmx.h b/macstl/impl/vec_mmx.h
index b3c3d43..999a4a9 100644
--- a/macstl/impl/vec_mmx.h
+++ b/macstl/impl/vec_mmx.h
@@ -969,8 +969,8 @@ namespace macstl
 						static INLINE const vec <double, 2> set ()
 						{
 							return impl::generator_m128d <
-								v0 & 0x00000000FFFFFFFFULL, (v0 & 0xFFFFFFFF00000000ULL) >> 32, 
-								v1 & 0x00000000FFFFFFFFULL, (v1 & 0xFFFFFFFF00000000ULL) >> 32>::call ();
+								v0 & 0x00000000FFFFFFFFULL, ((v0 & 0xFFFFFFFF00000000ULL) >> 32),
+								v1 & 0x00000000FFFFFFFFULL, ((v1 & 0xFFFFFFFF00000000ULL) >> 32)>::call ();
 						}
 					
 					template <init_type v0>
@@ -1622,8 +1622,8 @@ namespace macstl
 						static INLINE const vec <unsigned long long, 2> set ()
 						{
 							return impl::generator_m128i <
-								v0 & 0x00000000FFFFFFFFULL, (v0 & 0xFFFFFFFF00000000ULL) >> 32,
-								v1 & 0x00000000FFFFFFFFULL, (v1 & 0xFFFFFFFF00000000ULL) >> 32>::call ();
+								v0 & 0x00000000FFFFFFFFULL, ((v0 & 0xFFFFFFFF00000000ULL) >> 32),
+								v1 & 0x00000000FFFFFFFFULL, ((v1 & 0xFFFFFFFF00000000ULL) >> 32)>::call ();
 						}
 					
 					template <init_type v0>
@@ -1678,8 +1678,8 @@ namespace macstl
 						static INLINE const vec <long long, 2> set ()
 						{
 							return impl::generator_m128i <
-								((unsigned long long) v0) & 0x00000000FFFFFFFFULL, (((unsigned long long) v0) & 0xFFFFFFFF00000000ULL) >> 32,
-								((unsigned long long) v1) & 0x00000000FFFFFFFFULL, (((unsigned long long) v1) & 0xFFFFFFFF00000000ULL) >> 32>::call ();
+								((unsigned long long) v0) & 0x00000000FFFFFFFFULL, ((((unsigned long long) v0) & 0xFFFFFFFF00000000ULL) >> 32),
+								((unsigned long long) v1) & 0x00000000FFFFFFFFULL, ((((unsigned long long) v1) & 0xFFFFFFFF00000000ULL) >> 32)>::call ();
 						}
 					
 					template <init_type v0>
@@ -2775,7 +2775,7 @@ template <> struct FN##_function <ARG1*, ARG2 >													\
 
 				DEFINE_MMX_UNARY_FUNCTION_WITH_LITERAL (srai, _mm_srai_epi16, M128I_I16, M128I_I16)
 				DEFINE_MMX_UNARY_FUNCTION_WITH_LITERAL (srai, _mm_srai_epi32, M128I_I32, M128I_I32)
-				DEFINE_MMX_UNARY_FUNCTION_WITH_LITERAL (srai, _mm_srai_epi64, M128I_I64, M128I_I64)
+//					DEFINE_MMX_UNARY_FUNCTION_WITH_LITERAL (srai, _mm_srai_epi64, M128I_I64, M128I_I64)
 
 				DEFINE_MMX_BINARY_FUNCTION (srl, _mm_srl_epi16, M128I_I16, M128I_U16, M128I_I16)
 				DEFINE_MMX_BINARY_FUNCTION (srl, _mm_srl_epi16, M128I_U16, M128I_U16, M128I_U16)
