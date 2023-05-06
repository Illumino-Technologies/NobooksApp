architecture

test
 - subject `Subject`
 - question types `Enum List`
     * theory
     * multiple choice
     * german (fill in the blank)
     * practical
 - duration `int`
 - start time `DateTime`
 - end time `DateTime`
 - operations 
     - operation `AssessmentOperation`
       * serialId
       * question
         * content `NoteDocument`
       * answer
         * content `NoteDocument`
       * createdAt
       * updatedAt


fundamentally
 - students should not be allowed to exit the exam arena while it's being taken
 - students scores can or should be collected after the exam