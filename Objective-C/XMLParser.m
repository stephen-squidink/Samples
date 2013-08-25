/**
 * XML Parser
 * 
 * Parsing XML data is useful to load structured data set from a public service or a local configuration file.
 * The code sample shows how I load and parse a local XML file in the project. The view controller implements 
 * the NSXMLParserDelegate so I can implement the parseXMLFile and parser functions to handle the XML data set.
 */

<NSXMLParserDelegate>

[self parseXMLFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"xml"]];

- (void)parseXMLFile:(NSString *)pathToFile
{
  BOOL success;
    
  NSXMLParser *addressParser;
  NSURL *xmlURL = [NSURL fileURLWithPath:pathToFile];
    
  addressParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
  [addressParser setDelegate:self];
  [addressParser setShouldResolveExternalEntities:YES];
    
  success = [addressParser parse];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
  if ( [elementName isEqualToString:@"item"] )
  {
    [data addObject: [[attributeDict objectForKey:@"name"]] ];
  }
}
