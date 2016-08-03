class Adminer < Formula
  desc "Full-featured database management tool written in PHP."
  homepage "http://www.adminer.org/"
  url "https://www.adminer.org/static/download/4.2.5/adminer-4.2.5.php"
  sha256 "6fb52277b658ac00a812501a88cfe79e03750c5436dcd7427a707aa4459a8516"

  bottle do
    cellar :any_skip_relocation
    sha256 "e6b8ce60929c841c8755028d98a1fbee0d2e67ec7df23cfe5be674885351e71f" => :el_capitan
    sha256 "254c29ee3d70c9567473f4a47c3921ffb20a8fd2f6cd7478549b4bebdcf09ddd" => :yosemite
    sha256 "c989dd0e378e55f8ce2411790bd03337cdd9c2df218904248ea9144b615cd04e" => :mavericks
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
