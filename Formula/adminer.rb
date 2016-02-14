class Adminer < Formula
  desc "Full-featured database management tool written in PHP."
  homepage "http://www.adminer.org/"
  url "https://www.adminer.org/static/download/4.2.4/adminer-4.2.4.php"
  sha256 "ea21b95da1a2f66d26849160f3257823254663144e6b3b506c35160b70c7b3bd"

  bottle do
    cellar :any_skip_relocation
    sha256 "0b02652d94e1eaa93f2316866349a48cd61d28a2e00e7a993891b05739d1507e" => :el_capitan
    sha256 "4b6d7eb89f77fb1b279dba9ca9bf02803aa72fec1c5734ca01fe152e0ed332db" => :yosemite
    sha256 "ebcb0778cc35a27f69dad981ffac6b1fcfc23e7cf316bef4e19a81d624fc403a" => :mavericks
  end

  def install
    pkgshare.install "adminer-"+version+".php" => "index.php"
  end

  def caveats; <<-EOS.undent
    Note that this formula will NOT install MySQL or any other
    database. It is not required since you might want to get
    connected to a remote database server.

    Webserver configuration example (add this at the end of
    your /etc/apache2/httpd.conf for instance):

      Alias /adminer #{HOMEBREW_PREFIX}/share/adminer
      <Directory "#{HOMEBREW_PREFIX}/share/adminer/">
        Options None
        AllowOverride None
        <IfModule mod_authz_core.c>
          Require all granted
        </IfModule>
        <IfModule !mod_authz_core.c>
          Order allow,deny
          Allow from all
        </IfModule>
      </Directory>

    Then, open http://localhost/adminer
    EOS
  end

  test do
    system "php", "-l", "#{pkgshare}/index.php"
  end
end
