class Phpsh < Formula
  desc "read-eval-print-loop for php"
  homepage "http://www.phpsh.org/"
  url "https://github.com/facebook/phpsh/archive/1.3.tar.gz"
  sha256 "d3a24f3ebca0028d4ba226c3567407f7abc81d315577b0e0a4b67060630f129b"

  bottle do
    cellar :any_skip_relocation
    sha256 "c9cabc4cb82bfe70edd3e91cae62cc14fab70bb6edfe97f029af8cc2dcf2adb8" => :el_capitan
    sha256 "6edb1396460e4077709213b32bb64ab7101f65461e367ad104bb1d246a2db8a2" => :yosemite
    sha256 "c30f89f2fccb8b659f1448fb7078f1a3bdd8718bf62c854e809461c2abe26f74" => :mavericks
  end

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
