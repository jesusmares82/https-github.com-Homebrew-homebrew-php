class Adminer < Formula
  desc "Adminer is a full-featured database management tool written in PHP."
  homepage "http://www.adminer.org/"
  version '4.2.2'
  url "https://downloads.sourceforge.net/project/adminer/Adminer/Adminer%20" + version + "/adminer-" + version + ".php"
  sha256 "4dced0c64dbeb0f6e9a27c4ec5838bbf5f33b82c368a8965b47ae3da6c9bcb2c"

  def install
    (share+"adminer").install "adminer-"+version+".php" => "index.php"
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
end
