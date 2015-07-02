class Adminer < Formula
  desc "Adminer is a full-featured database management tool written in PHP."
  homepage "http://www.adminer.org/"
  url "https://downloads.sourceforge.net/project/adminer/Adminer/Adminer%204.2.1/adminer-4.2.1.php"
  sha256 "f7471d6f006b3db84a4919a216436b3be5c1468053497161696ecfddbb538ed1"

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
