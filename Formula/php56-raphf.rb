require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Raphf < AbstractPhp56Extension
  init
  desc "Split-off of pecl_http's persistent handle and resource factory API"
  homepage "https://pecl.php.net/package/raphf"
  url "https://github.com/m6w6/ext-raphf/archive/release-1.1.2.tar.gz"
  sha256 "b5386eff888e2c06951b4fa65a3d0b536775e35a8afc2db323a3129685f7c2bf"
  revision 2

  bottle do
    cellar :any_skip_relocation
    sha256 "e44f6a1caa74c6b4379e4e226efb555abf5949025b131c2b814f3c5677537caf" => :el_capitan
    sha256 "46cab1e94ee486fc1fc3d7fce7a50fb4eef800ac2626bbbd43f3a048c0853644" => :yosemite
    sha256 "aea9c4419349302a15a307fb2cf0cbd93ff5bba535544bf9de2d36512f38e744" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    include.install %w[php_raphf.h src/php_raphf_api.h]
    prefix.install "modules/raphf.so"
    write_config_file if build.with? "config-file"
  end
end
