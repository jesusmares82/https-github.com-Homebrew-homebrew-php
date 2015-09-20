class Phpsh < Formula
  desc "read-eval-print-loop for php"
  homepage "http://www.phpsh.org/"
  url "https://github.com/facebook/phpsh/archive/1.3.tar.gz"
  sha256 "d3a24f3ebca0028d4ba226c3567407f7abc81d315577b0e0a4b67060630f129b"

  depends_on "pcre"
  depends_on :python

  # fixes https://github.com/facebook/phpsh/pull/46 and https://github.com/josegonzalez/homebrew-php/issues/966
  patch :DATA

  def install
    system "python", "setup.py", "install", "--prefix=#{prefix}"

    man1.install ["src/doc/phpsh.1"]
    rm_rf("#{prefix}/man")
    bin.install ["src/phpsh"]
  end

  test do
    system "phpsh"
  end
end

__END__
diff --git a/src/__init__.py b/src/__init__.py
index 31b3474..a4a64d2 100644
--- a/src/__init__.py
+++ b/src/__init__.py
@@ -801,7 +801,16 @@ Type 'e' to open emacs or 'V' to open vim to %s: %s" %
                 # at this point either:
                 #  the php instance died
                 #  select timed out
+
+                # read till the end of the file
                 l = self.comm_file.readline()
+                lastline = l
+                while l.strip() != "":
+                    l = self.comm_file.readline()
+                    if l.strip() != "":
+                        lastline = l
+                l = lastline
+
                 if l.startswith("child"):
                     ret_code = self.p.poll()
                     os.kill(self.p.pid, signal.SIGHUP)
