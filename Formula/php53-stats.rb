require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Stats < AbstractPhp53Extension
  init
  homepage "https://pecl.php.net/package/stats"
  url "https://pecl.php.net/get/stats-1.0.3.tgz"
  sha1 "eb0c805ee51bf363d4376ed5281bbefeea408574"
  head "https://svn.php.net/repository/pecl/stats/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "2f3885553e11684662a57dfa197f8dbdc8942ec2dbb5214fc2824c8fa16be158" => :mavericks
  end

  def install
    Dir.chdir "stats-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/stats.so"
    write_config_file if build.with? "config-file"
  end
end
