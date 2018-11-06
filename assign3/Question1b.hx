
/**
 * Represnets a parser for the grammar developed in Question 1a
 */
class Parser{

    /**
     * Contains the words to be parsed
     */
    var wordlist = new Array<String>();
    var wordlistcopy = new Array<String>();
    var removed_words = new Array<String>();
    var f:Bool = false;

    /**
     * Constructor for Parser
     */
    public function new(?wordlist:Array<String>){
        if(wordlist!=null){
        this.wordlist = wordlist;
        this.wordlistcopy = new Array<String>();
        for (s in this.wordlist){
            this.wordlistcopy.push(s);
        } 
        }
    }

    /**
     * Set's the word to be parsed
     * @param wordlist The list containing the word to be parsed
     */
    public function set_word(wordlist:Array<String>){
        this.wordlist = wordlist;
        this.wordlistcopy = new Array<String>();
        for (s in this.wordlist){
            this.wordlistcopy.push(s);
        } 
    }

    public function parse(){
        this.f = run_parser();
        return this.f;
    }

    public function consume(string:String){
        this.removed_words.push(string);
        this.wordlist.remove(string);
    }

    public function restore(){
        for (s in this.removed_words) {
            this.wordlist.insert(0,s);
        }
        this.removed_words = new Array<String>();
    }

    public function clear_restore(){
        this.removed_words = new Array<String>();
    }

    private function restore_array(){
        this.wordlist = new Array<String>();
        for (s in this.wordlistcopy) {
            this.wordlist.push(s);
        }
    }
    private function run_parser():Bool{
        if(comp() && id() && this.wordlist.length==0){
            return true;
        }
        restore_array();
        this.clear_restore();
        if(opercomp() && b() && this.wordlist.length==0){
            return true;
        }
        restore_array();
        this.clear_restore();
        if(b() && this.wordlist.length==0){
            return true;
        }
        restore_array();
        this.clear_restore();
        if(logic() && compar() && this.wordlist.length==0){
            return true;
        }
        restore_array();
        this.clear_restore();
        if(sb() && this.wordlist.length==0){
            return true;
        }
        restore_array();
        this.clear_restore();
        if(loops() && compar() && this.wordlist.length==0){
            return true;
        }
        restore_array();
        this.clear_restore();
        if(opercomp() && operat() && this.wordlist.length==0){
            return true;
        }
        restore_array();
        this.clear_restore();
        if(operb() && compoper()&&this.wordlist.length==0){
            return true;
        }
        restore_array();
        this.clear_restore();
        if(b() && compoper()&& this.wordlist.length==0){
            return true;
        }
        restore_array();
        this.clear_restore();
        if(operat() && bcomp()){
            return true;
        }
        return false;
    }
    
    private function bcomp(){
        if(relop() && id()){
            this.clear_restore();
            return true;
        }
        this.restore();
        return false;
    }

    private function operb(){
        if(b() && op()){
            this.clear_restore();
            return true;
        }
        this.restore();
        return false;
    }
    
    private function compoper(){
        if((comp()||relop()) && operat()){
            this.clear_restore();
            return true;
        }
        this.restore();
        return false;
    }

    private function logic(){
        if(compar() && predop()){
            this.clear_restore();
            return true;
        }
        this.restore();
        return false;
    }

    private function compar(){
        if(comp() && (id()||num())){
            this.clear_restore();
            return true;
        }
        this.restore();
        return false;
    }

    private function opercomp(){
        if(operat() && relop()){
            this.clear_restore();
            return true;
        }
        this.restore();
        return false;
    }

    private function operat(){
        if(oper() && (id() || num())){
            this.clear_restore();
            return true;
        }
        this.restore();
        return false;
    }

    private function oper(){
        if(id() && op()){
            this.clear_restore();
            return true;
        }
        this.restore();
        return false;
    }

    private function comp(){
        if(id() && relop()){
            this.clear_restore();
            return true;
        }
        this.restore();
        return false;
    }

    private function logicb(){
        if(logic() && (comparb() || opcomp())){
            this.clear_restore();
            return true;
        }
        this.restore();
        return false;
        
    }

    private function comparb(){
        if(compar() && b()){
            this.clear_restore();
            return true;
        }
        this.restore();
        return false;
    }
    
    private function b(){
        if((ob() || check_lb()) && cb()){
            this.clear_restore();
            return true;
        }
        this.restore();
        return false;
    }

    private function sb(){
        if(sob() && scb()){
            this.clear_restore();
            return true;
        }
        this.restore();
        return false;
    }

    private function sob(){
        if((logic() || loops()) && check_slb()){
            this.clear_restore();
            return true;
        }
        this.restore();
        return false;
    }

    private function loops(){
        if(loop() && check_col()){
            this.clear_restore();
            return true;
        }
        this.restore();
        return false;
    }

    private function loop(){
        if(quant() && id()){
            this.clear_restore();
            return true;
        }
        this.restore();
        return false;
    }

    private function scb(){
        if((logicb() || loopar()) && check_srb()){
            this.clear_restore();
            return true;
        }
        this.restore();
        return false;
    }

    private function loopar(){
        if(loops() && compar()){
            this.clear_restore();
            return true;
        }
        this.restore();
        return false;
    }

    private function opcomp(){
        if(oper() && comparant()){
            this.clear_restore();
            return true;
        }
        this.restore();
        return false;
    }

    private function comparant(){
        if(comp() && num()){
            this.clear_restore();
            return true;
        }
        this.restore();
        return false;
    }

    private function ob():Bool{
        if((oper()||comp()||op()) && check_lb()){
            this.clear_restore();
            return true;
        }
        this.restore();
        return false;
    }

    private function cb():Bool{
        if(operat() && check_rb()){
            this.clear_restore();
            return true;
        }
        this.restore();
        return false;
    }

    private function id(){
        var list = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];
        var string:String = this.wordlist[0];
        if(string.length>1){
            var holder:Bool =false;
            for(i in 0...string.length){
                holder =false;
                for(s in list){
                    if(string.charAt(i) == s){
                        holder = true;
                    }
                }
            }
            if(holder == true){
                this.consume(string);
                return true;
            }else {
                return false;
            }
        }else{
        for (s in list){
            if (string == s){
                this.consume(string);
                return true;
            }
        }
        return false;
        }
    }

    private function num(){
        var list = ['0','1','2','3','4','5','6','7','8','9'];
        var string:String = this.wordlist[0];
        if(string.length>1){
            var holder:Bool =false;
            for(i in 0...string.length){
                holder =false;
                for(s in list){
                    if(string.charAt(i) == s){
                        holder = true;
                    }
                }
            }
            if(holder == true){
                this.consume(string);
                return true;
            }else {
                return false;
            }
        }else{
        for (s in list){
            if (string == s){
                this.consume(string);
                return true;
            }
        }
        return false;
        }
    }

    private function op(){
        var list = ['-','+','*','/'];
        var string = this.wordlist[0];
        for (s in list){
            if (string == s){
                this.consume(string);
                return true;
            }
        }
        return false;
    }

    private function relop(){
        var list = ['=','<','>','<=',">="];
        var string = this.wordlist[0];
        for (s in list){
            if (string == s){
                this.consume(string);
                return true;
            }
        }
        return false;
    }

    private function predop(){
        var list = ['AND','OR','IMP'];
        var string = this.wordlist[0];
        for (s in list){
            if (string == s){
                this.consume(string);
                return true;
            }
        }
        return false;
    }

    private function quant(){
        var list = ['FORALL','EXISTS'];
        var string = this.wordlist[0];
        for (s in list){
            if (string == s){
                this.consume(string);
                return true;
            }
        }
        return false;
    }

    private function check_rb(){
        var string = this.wordlist[0];
        if (this.wordlist[0]==')'){
            this.consume(string);
            return true;
        }
        return false;
    }

    private function check_lb(){
        var string = this.wordlist[0];
        if (this.wordlist[0]=='('){
            this.consume(string);
            return true;
        }
        return false;
    }

    private function check_srb(){
        var string = this.wordlist[0];
        if (this.wordlist[0]==']'){
            this.consume(string);
            return true;
        }
        return false;
    }

    private function check_slb(){
        var string = this.wordlist[0];
        if (this.wordlist[0]=='['){
            this.consume(string);
            return true;
        }
        return false;
    }

    private function check_col(){
        var string= this.wordlist[0];
        if(string == '::'){
            this.consume(string);
            return true;
        }
        return false;
    }

}

/**
 * Runs checks on the parser described above
 */
class Question1b{

    static function main(){
        var parser = new Parser();
        var holder:Bool;
        parser.set_word(["x", ">", "y"]);
        holder = parser.parse();
        if(holder == true){
            trace('Test 1: Pass'); //True
        }else{
            trace('Test 1: Failed');
        }
        parser.set_word(["x"]);
        holder = parser.parse();
        if(holder == false){
            trace('Test 2: Pass'); //False
        }else{
            trace('Test 2: Failed');
        }
        parser.set_word(["x", "+", "y"]);
        holder = parser.parse();
        if(holder == false){
            trace('Test 3: Pass'); //False
        }else{
            trace('Test 3: Failed');
        }
        parser.set_word(['x','+','y','>=','x','*','(','y','-','3',')']);
        holder = parser.parse();
        if(holder == true){
            trace('Test 4: Pass'); //True
        }else{
            trace('Test 4: Failed');
        }
        parser.set_word(['y','>','(','y','-','3',')']);
        holder = parser.parse();
        if(holder == true){
            trace('Test 5: Pass'); //True
        }else{
            trace('Test 5: Failed');
        }
        parser.set_word(['x','<','y','AND','y','<','z']);
        holder = parser.parse();
        if(holder == true){
            trace('Test 6: Pass'); //True
        }else{
            trace('Test 6: Failed');
        }
        parser.set_word( ["x", ">", "y", "AND", "[", "y", "=", "z", "OR", "y", "=", "z", "*", "(", "x", "+", "1", ")", "]"]);
        holder = parser.parse();
        if(holder == true){
            trace('Test 7: Pass'); //True
        }else{
            trace('Test 7: Failed');
        }
        parser.set_word(['x','>','y','AND','[','y','=','z','OR','y','=','z','*','(','x','+','1',')',']']);
        holder = parser.parse();
        if(holder == true){
            trace('Test 8: Pass'); //True
        }else{
            trace('Test 8: Failed');
        }
        parser.set_word(['FORALL','x','::','[','x','<','5','IMP','x','*','x','<','25',']']);
        holder = parser.parse();
        if(holder == true){
            trace('Test 9: Pass'); //True
        }else{
            trace('Test 9: Failed');
        }
        parser.set_word(['FORALL','x','::','x','>','y']);
        holder = parser.parse();
        if(holder == true){
            trace('Test 10: Pass'); //True
        }else{
            trace('Test 10: Failed');
        }
        parser.set_word(['FORALL','x','::','[','x','AND','y',']']);
        holder = parser.parse();
        if(holder == false){
            trace('Test 11: Pass'); //False
        }else{
            trace('Test 11: Failed');
        }
        parser.set_word(['EXISTS','y','::','[','FORALL','x','::','x','>','y',']']);
        holder = parser.parse();
        if(holder == true){
            trace('Test 12: Pass'); //True
        }else{
            trace('Test 12: Failed');
        }
        parser.set_word(["EXISTS", "y", "::", "[", "FORALL", "x", "::", "x", ">", "y"]);
        holder = parser.parse();
        if(holder == false){
            trace('Test 13: Pass'); //false
        }else{
            trace('Test 13: Failed');
        }
        parser.set_word(["x", "+", "y", ">", "yz", "+", "xxx"]);
        holder = parser.parse();
        if(holder == true){
            trace('Test 14: Pass'); //True
        }else{
            trace('Test 14: Failed');
        }
        parser.set_word(["(", "x", "+", "y", ")", "*", "z", ">", "yz", "+", "xxx"]);
        holder = parser.parse();
        if(holder == true){
            trace('Test 15: Pass'); //True
        }else{
            trace('Test 15: Failed');
        }
        parser.set_word(["(", "x", "+", "y", "*", "z", ">", "yz", "+", "xxx"]);
        holder = parser.parse();
        if(holder == false){
            trace('Test 16: Pass'); //false
        }else{
            trace('Test 16: Failed');
        }
        parser.set_word(["x", "+", "(", "y", "*", "z", ")", ">", "yz", "+", "xxx"]);
        holder = parser.parse();
        if(holder == true){
            trace('Test 17: Pass'); //True
        }else{
            trace('Test 17: Failed');
        }
        parser.set_word(["x", "*", "y", "=", "qr"]);
        holder = parser.parse();
        if(holder == true){
            trace('Test 18: Pass'); //True
        }else{
            trace('Test 18: Failed');
        }
        parser.set_word(["x", "y"]);
        holder = parser.parse();
        if(holder == false){
            trace('Test 19: Pass'); //false
        }else{
            trace('Test 19: Failed');
        }
    }
}