class Adminer < Formula
  desc "Adminer is a full-featured database management tool written in PHP."
  homepage "http://www.adminer.org/"
  version "4.2.3"
  url "https://www.adminer.org/static/download/" + version + "/adminer-" + version + ".php"
  sha256 "40e72c917aa4f5f19d39b7322322989fd3b752131821b9f13459ca765796957c"

  bottle do
    cellar :any_skip_relocation
    sha256 "bcfb05854a5e5451bd6cd83e33082fd4edf55616128f1431a7f30425611e4a51" => :el_capitan
    sha256 "8e156b95803303b9918d7994e45c8e5e0073de081f1fd17dc2e48d1325597492" => :yosemite
    sha256 "a1e94376205985a78dd840edb7b0e2a18920cf355acaa88d6772f02e9f5e6af7" => :mavericks
  end

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
