require 'formula'

class Phplint < Formula
  homepage 'http://www.icosaedro.it/phplint/'
  url 'http://www.icosaedro.it/phplint/phplint-pure-c-1.1_20130803.tar.gz'
  sha256 '30620b170315e9b9df1f69fdf809a1ec0e4829263e7b9949d88ab22b4ce80388'
  version '1.1-20130803'
  fails_with :clang do
    # See: http://www.icosaedro.it/phplint/download.html (Note 1)
    cause 'Clang which does not support nested functions. Use gcc instead.'
  end

  def patches
    # Rationale: The ./configure tosses up errors that can be ignored, but homebrew
    #     still catches them, so I've just patched in the file that gets created.
    #     As for phpl, it's useful because it includes the default modules with
    #     --modules-path, but the default options are WAY too verbose.
    DATA
  end

  def install
    system "#{ENV.cc} -fnested-functions src/phplint.c -o src/phplint"
    bin.install 'src/phplint'
    bin.install 'phpl'
    prefix.install 'modules'
  end
end

__END__
diff --git a/include/missing.c b/include/missing.c
new file mode 100644
index 0000000..576b7ab
--- /dev/null
+++ b/include/missing.c
@@ -0,0 +1,3 @@
+#define M2_SYSTEM_TYPE "UNKNOWN"
+#define M2_SYSTEM_TYPE_UNKNOWN
+#define INTSTR(b1,b2,b3,b4) #b1#b2#b3#b4
diff --git a/phpl b/phpl
index 03a55eb..f195fba 100755
--- a/phpl
+++ b/phpl
@@ -6,13 +6,10 @@
 #
 # Try phplint --help for more.

-d=$(dirname "$0")
+d=$(brew --prefix phplint)

-"$d/src/phplint" \
-	--tab-size 8 \
+"$d/bin/phplint" \
 	--no-print-file-name \
 	--print-path shortest \
 	--modules-path "$d/modules" \
-	--print-source \
-	--print-context \
 	"$@"
