require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Dbus < AbstractPhp53Extension
  init
  homepage "https://pecl.php.net/package/dbus"
  url "https://pecl.php.net/get/dbus-0.1.1.tgz"
  sha256 "018ce17ceb18bd7085f7151596835b09603140865a49c76130b77e00bc7fcdd7"
  head "http://svn.php.net/repository/pecl/dbus/trunk/"

  bottle do
    sha256 "96a2f1b9ddd5f1a685f3b85befbb5b859569ed8be1e55228268c513f48809b9a" => :el_capitan
    sha256 "f7cbae6393227842620f64cc989301579249e2aa68ff2a4d9ba9bf3b695004a7" => :yosemite
    sha256 "7df58ac21901e6f254dd9e61fcaa8f00164c2b50d349c3f7fff60c43d30b4d2e" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "d-bus" => :build

  def install
    Dir.chdir "dbus-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/dbus.so"
    write_config_file if build.with? "config-file"
  end
end
