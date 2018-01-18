class Adminer < Formula
  desc "Full-featured database management tool written in PHP."
  homepage "https://www.adminer.org"
  url "https://github.com/vrana/adminer/releases/download/v4.4.0/adminer-4.4.0.php"
  sha256 "18400c26245de0d362a5cb261e62091e48887c9e983ad2e471adcd6943eb41e3"

  bottle do
    cellar :any_skip_relocation
    sha256 "52994060e5618432ce25664d46fab63e3ebbdf1ad1856cbb7add6ec8fdfda6bc" => :high_sierra
    sha256 "52994060e5618432ce25664d46fab63e3ebbdf1ad1856cbb7add6ec8fdfda6bc" => :sierra
    sha256 "52994060e5618432ce25664d46fab63e3ebbdf1ad1856cbb7add6ec8fdfda6bc" => :el_capitan
  end

  def install
    pkgshare.install "adminer-"+version+".php" => "index.php"
  end

  def caveats; <<~EOS
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
