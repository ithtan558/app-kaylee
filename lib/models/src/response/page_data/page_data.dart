class PageData<T> {
  PageData({
    this.page,
    this.limit,
    this.total,
    this.pages,
    this.items,
  });

  int page;
  int limit;
  int total;
  int pages;
  T items;
}
