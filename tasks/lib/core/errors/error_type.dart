enum ErrorType {
  /// A critical error that prevents the application from functioning properly. 
  /// This type of error should be addressed immediately.
  critical,
  // An informational error that does not prevent the application 
  //from functioning properly, but may provide additional 
  //information that is helpful to the user.
  info,
  //	A warning error that indicates a potential problem 
  //that could lead to an error in the future. 
  //This type of error should be monitored and addressed if necessary.
  warning,
  // 	A network error that prevents the application from communicating
  // with the server. This type of error is typically caused by a 
  //problem with the network connection.
  network,
  // 	A session timeout error that indicates that the user's session has expired.
  // This type of error typically occurs when the user has not interacted with
  // the application for a period of time.
  sessionTimeout,
}