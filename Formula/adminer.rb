class Adminer < Formula
  desc "Full-featured database management tool written in PHP."
  homepage "https://www.adminer.org"
  url "https://github.com/vrana/adminer/releases/download/v4.3.1/adminer-4.3.1.php"
  sha256 "c26f48bc06c195928dee9ca5d5a485d86a8b14d420368061fd8045ac26fcc701"

  bottle do
    cellar :any_skip_relocation
    sha256 "9d5bfabc11066ff53cb01e0cfa24e121572faf369c144408b00c1d4e8384093d" => :sierra
    sha256 "2148b456ddc90dd098d918f598f8ad17eeccf1fdec5664198ff4866147205982" => :el_capitan
    sha256 "2148b456ddc90dd098d918f598f8ad17eeccf1fdec5664198ff4866147205982" => :yosemite
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
