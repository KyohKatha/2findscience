package Pkg2FindScience;

public class PublicationDAOException extends Exception {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public PublicationDAOException(){ }
	
	public PublicationDAOException(String arg){
		super(arg);
	}
	
	public PublicationDAOException(Throwable arg){
		super(arg);
	}
	
	public PublicationDAOException(String arg,Throwable arg1){
		super(arg,arg1);
	}
}
