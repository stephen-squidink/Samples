/**
 * Page Scroll Views
 * 
 * One of the common features to build in an app is the ability to scroll through pages like a magazine. To do
 * this I use a UIScrollView to store all the pages. I create the frame of the scroll view to the size of a page.
 * I then iterate through all the content images and add them to the scroll view and position them in the write 
 * place by multiplying the page width by page index. The scroll view content size is set to the number of items 
 * multiplied by the page width.
 */

CGRect scrollFrame = CGRectMake(0.0f, 0.0f, 1024.0f, 724.0f);
self.scrollView.frame = scrollFrame;

for (int i = 0; i < contents.count; i++)
{
  CGRect frame;
  frame.origin.x = self.scrollView.frame.size.width * i;
  frame.origin.y = 0;
  frame.size = self.scrollView.frame.size;
	
  UIImageView *subview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:contents[i]]];
    
  subview.frame = frame;
  [self.scrollView addSubview:subview];
}

self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * contents.count, self.scrollView.frame.size.height);

/**
 * Once the content is set up, I had to implement the UIScrollViewDelegate in my view controller so I can register
 * the scrollViewDidScroll function. This function listens and handles for a user scrolling on the UIScrollView. 
 * When it detects a swipe and scroll the page changes and triggers the changePage function which sets the scroll
 * view visible rectangle based on the page index.
 */

<UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
  if (!pageControlBeingUsed)
  {
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2)/pageWidth) + 1;
      
    self.pageControl.currentPage = page;
  }
}

- (IBAction)changePage
{
  CGRect frame;
  frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
  frame.origin.y = 0;
  frame.size = self.scrollView.frame.size;
  [self.scrollView scrollRectToVisible:frame animated:YES];
    
  pageControlBeingUsed = YES;
}
