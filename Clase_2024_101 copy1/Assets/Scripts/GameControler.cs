/*
Keep track of scores and ball status

Isaac Shakalo
19-02-2024
*/

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameControler : MonoBehaviour
{
    public GameObject dot;
    public float force;
    // Start is called before the first frame update
    void Start()
    {
        StartGame();
    }
    // Update is called once per frame
    void Update()
    {
        
    }

    void StartGame(){
       
        dot.GetComponent<Rigidbody2D>().velocity = Random.onUnitSphere * force;
    }
}
