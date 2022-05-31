class Crawler

  include Process

  def initialize crawler_count = 1
    @crawler_count = crawler_count
  end

  def pooling_crawl crawl_target

    pool_size = crawl_target.count / @crawler_count
    pooled_crawl_target = crawl_target.each_slice pool_size

    pooled_crawl_target.to_a.map do |pool|
      Thread.new do
        pool.map do |pool_unit|
          yield pool_unit
        end
      end
    end.map(&:join).flatten
  end
end
