class Adminer < Formula
  desc "Adminer is a full-featured database management tool written in PHP."
  homepage "http://www.adminer.org/"
  version "4.2.2"
  url "https://downloads.sourceforge.net/project/adminer/Adminer/Adminer%20" + version + "/adminer-" + version + ".php"
  sha256 "4dced0c64dbeb0f6e9a27c4ec5838bbf5f33b82c368a8965b47ae3da6c9bcb2c"

  bottle do
    cellar :any_skip_relocation
    sha256 "127d8ecb0d2fa755dd44dd63d1c494db734ab48408befb2143fa79e603e3bc04" => :yosemite
    sha256 "f39cedb75643dfd9638b43b10888190b359d3d472eb973b0c39d2bac208556a9" => :mavericks
    sha256 "6b3525282d16ad79acf8aa32c9281f43b28ab728af76aad460743becb851df0e" => :mountain_lion
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
