(*
 Implementation of fibonacci in Coq!
*)

(* The direct implementation *)
Fixpoint fib_direct (n : nat) : nat :=
  match n with
    | 0 => 0
    | S n' => match n' with
                | 0 => 1
                | S n'' => fib_direct n'' + fib_direct n'
              end
  end.

Compute fib_direct 10.


(* The tail recursive Fibonacci *)
Fixpoint fib_accumulator (n : nat) (a : nat) (b : nat) : nat :=
  match n with
    | 0     => a
    | (S n') => fib_accumulator n' (a+b) a
  end.

(* An alias to scrape away unnecessary information *)
Definition fib_acc (n : nat) := fib_accumulator n 0 1.

(* Test that it *)
Compute fib_acc 10.


(* As Coq is a proof assistant, we try to prove that the two above functions
 are in equivalent *)

(* We define what fibonacci is *)
Definition specification_of_fibonacci (f : nat -> nat) :=
  f 0 = 0
  /\
  f 1 = 1
  /\
  forall n : nat,
    f (S (S n)) = f n + f (S n).


(* We make sure that the definition is unambigious *)
Lemma there_is_only_one_fib :
  forall f1 f2 : nat -> nat,
    specification_of_fibonacci f1 ->
    specification_of_fibonacci f2 ->
    forall n : nat,
      f1 n = f2 n.
Proof.
  unfold specification_of_fibonacci.
  intros f1 f2.
  intros [ bc_f1_0 [ bc_f1_1 ic_f1 ] ]. (* Destruct the conjunctive clauses *)
  intros [ bc_f2_0 [ bc_f2_1 ic_f2 ] ].
   
  (* strengthening the induction hypothesis *)
  assert (H_fib : forall m : nat,
                    f1 m = f2 m /\ f1 (S m) = f2 (S m)).
  intro m.
  induction m as [| m' [IHm' IHSm']].
  
  split.
    rewrite bc_f1_0.
    rewrite bc_f2_0.
    reflexivity.

    rewrite bc_f1_1.
    rewrite bc_f2_1.
    reflexivity.


  split.
    apply IHSm'.
    
    rewrite ic_f1.
    rewrite ic_f2.
    rewrite IHm'.
    rewrite IHSm'.
    reflexivity.
    
  intro n.
  destruct (H_fib n) as [hf _].
  apply hf.
Qed.
    
Lemma unfold_fib_direct_ic :
  forall n : nat,
    fib_direct (S (S n)) = fib_direct n + fib_direct (S n).
Proof.
  intro n.
  unfold fib_direct; fold fib_direct.
  reflexivity.
Qed.

Lemma fib_direct_satisfies_spec :
  specification_of_fibonacci fib_direct.
Proof.
  unfold specification_of_fibonacci.
  split.
  unfold fib_direct.
  reflexivity.
  
  split.
  unfold fib_direct.
  reflexivity.

  intro n.
  rewrite unfold_fib_direct_ic.
  reflexivity.
Qed.

Lemma unfold_fib_accumulator_bc0 :
  fib_accumulator 0 0 1 = 0.
Proof.
  unfold fib_accumulator.
  reflexivity.
Qed.

Lemma about_fib_acc :
  forall f : nat -> nat,
    specification_of_fibonacci f ->
    forall k i : nat,
      fib_accumulator k (f (S i)) (f i) = f (k + i).
Proof.
  Admitted.

(*
TODO: 
* Prove that fib_accumulator satisfies specification
* Prove that fib_accumulator and fib_direct are equivalent

*)